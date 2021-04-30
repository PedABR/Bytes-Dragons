module MainPersonagem where
import Personagem as Persona
import Classe
import Raca
import System.IO
import System.Process
import System.FilePath.Posix
import System.Directory
import System.Random
import Data.Maybe
import Util
import Data.List
import Habilidade
import Item
import Batalha
import Habilidade as Habil

menuPersng :: IO ()
menuPersng = do
    let menuP = [ ("1", listarPersng)
            , ("2", criarPersng)
            , ("3", detalhesPersng)
            , ("4", excluirPersng)
            , ("5", menuItemHabil)
            , ("6", botaResistencia)
            , ("7", menuBatalhaInicial)
            , ("0", print"")
            ]
    system "clear"
    putStrLn "1 - Listar Personagens\n2 - Criar Personagem\n3 - Detalhes de Personagem\n4 - Excluir Personagem\n5 - Menu de Relacao Item/Habilidade com Personagem\n6 - Alterar ouro de Personagem\n7 - Especificar Resistencias\n9 - Inicar Batalha entre Personagens\n0 - Voltar Menu\n"
    tipo <- getLine
    let action = lookup tipo (menuP)
    verificaEntradaMenu action

listarPersng :: IO ()
listarPersng = do
    system "clear"
    contents <- readFile "data/persngs.bd"
    print "---> "
    putStrLn $ Persona.listarPersonagens (transformaListaPersonagem (lines contents))
    print " <---"
    restart menuPersng


detalhesPersng :: IO ()
detalhesPersng = do
    system "clear"
    putStrLn "Qual o Nome do Personagem?"
    nome <- getLine
    contents <- readFile "data/persngs.bd"
    putStrLn (getDetalhesPersng (lines contents) nome)
    restart menuPersng
            
getDetalhesPersng :: [String] -> String -> String
getDetalhesPersng personas nome = 
    (Persona.exibePersonagem (transformaListaPersonagem personas) nome)


criarPersng :: IO ()
criarPersng = do
    putStrLn "Qual o nome do Personagem?"
    nome <- getLine
    putStrLn "Qual a Raça do Personagem (Hobbit | Anao | Elfo | Gnomo | Humano | Ogro) ?"
    raca <- getLine
    putStrLn "Qual a classe do Personagem (Bruxo | Barbaro | Bardo | Clerigo | Druida | Feiticeiro | Guerreiro | Ladino | Mago | Monge | Paladino | Arqueiro) ?"
    classe <- getLine  
    appendFile "data/persngs.bd" (show (Persona.cadastraPersonagem nome (read classe :: Classe) (read raca :: Raca)) ++ "\n")
    putStrLn "Personagem Criado"
    restart menuPersng


excluirPersng :: IO ()
excluirPersng = do
    system "clear"
    putStrLn "Qual o Nome do Personagem?"
    nome <- getLine
    contents <- readFile "data/persngs.bd"
    let persng_possi = getDetalhesPersng (lines contents) nome
    if (persng_possi == "Personagem inexistente\n") then (putStrLn persng_possi) else (deletePersng (lines contents) (getPersng (transformaListaPersonagem (lines contents)) nome))
    restart menuPersng


deletePersng ::  [String] -> (Maybe (Personagem)) -> IO ()
deletePersng listaPersng persngMayb = do
    if (not (isNothing persngMayb))
        then do
            let persng = fromJust (persngMayb)
            (tempName, tempHandle) <- openTempFile "data/" "temp"
            hPutStr tempHandle $ unlines ((listaPersng \\ [(show persng)]))
            hClose tempHandle
            removeFile "data/persngs.bd"
            renameFile tempName "data/persngs.bd"
            putStrLn "Personagem excluido com Sucesso\n"
        else putStrLn "Personagem inexistente\n"

menuItemHabil :: IO ()
menuItemHabil = do
    system "clear"
    let menuIHP = [ ("1", linkarItemPersng)
            , ("2", linkarHabil)
            , ("3", desequiparItemPerson)
            , ("4", desalocarHabil)
            , ("9", menuPersng)
            ]
    putStrLn "1 - Equipar um Item\n2 - Equipar uma Habilidade\n3 - Desequipar um Item\n4 - Desalocar uma Habilidade"
    tipo <- getLine
    let action = lookup tipo (menuIHP)
    verificaEntradaMenu action

    
linkarItemPersng :: IO ()
linkarItemPersng = do   
    system "clear"
    putStrLn "Qual o Tipo de Item Desejado?\n1 - Equipavel\nOu\n2 - Consumivel"
    tipo <- getLine
    if (tipo /= "1" && tipo /= "2") then putStrLn "Entrada Invalida"
        else do
            putStrLn "Qual o ID do Item?"
            entrada <- getLine
            let id = read entrada :: Int
            itemStr <- getFromTipo tipo
            if (id >= (length(lines itemStr))) then putStrLn "Id Invalida" 
                else do
                    let item = (lines itemStr) !! id
                    putStrLn "Qual o nome do Personagem?"
                    nome <- getLine
                    filePerson <- readFile "data/persngs.bd"
                    let persngsString = lines filePerson
                    let person = getPersng (transformaListaPersonagem persngsString) nome
                    if (isNothing person)
                        then do
                            putStrLn "Personagem Inexistente"
                        else do
                            if (tipo == "1") then (linkarEquipPerson (fromJust person) (getEquipavelFromString item))
                                else (linkarConsmvlPerson (fromJust person) (getConsmvlFromString item))
    restart menuPersng


linkarHabil :: IO ()
linkarHabil = do
    system "clear"
    putStrLn "Qual o ID da Habilidade?"
    entrada <- getLine
    let id = read entrada :: Int
    contents <- readFile "data/habil.info"
    if (id >= (length(lines contents))) then putStrLn "Id Invalida" 
        else do
            let habilidade = (lines contents) !! id
            putStrLn "Qual o nome do Personagem?"
            nome <- getLine
            filePerson <- readFile "data/persngs.bd"
            let persngsString = lines filePerson
            let person = getPersng (transformaListaPersonagem persngsString) nome
            if (isNothing person) then putStrLn "Personagem Inexistente"
                else do
                    linkarHabilPerson (fromJust person) (getHabilFromString habilidade)
    restart menuPersng



botaResistencia :: IO ()
botaResistencia = do
    putStrLn "Qual A Resistencia? (Cortante | Magico | Venenoso | Fogo | Gelo | Fisico)"
    entrada <- getLine
    let resistencia = read entrada :: TipoDano
    putStrLn "Qual o nome do Personagem?"
    nome <- getLine
    filePerson <- readFile "data/persngs.bd"
    let persngsString = lines filePerson
    let person = getPersng (transformaListaPersonagem persngsString) nome
    if (isNothing person)
        then do
            putStrLn "Personagem Inexistente"
            restart menuPersng
        else do
            let pessoa = fromJust person
            replacePersonOnFile (Persona.adicionarImunidade pessoa resistencia) pessoa
            restart menuPersng


menuBatalhaInicial :: IO ()
menuBatalhaInicial = do
    system "clear"
    putStrLn "Quais são os Personagem que irão participar da Batalha? (Nomes)"
    nomes <- getMultipleLines
    personagensString <- readFile "data/persngs.bd"
    let personagens = getPersonagens nomes (transformaListaPersonagem (lines personagensString))
    putStrLn "Os personagens escolhidos foram:"
    putStrLn (Persona.listarPersonagens personagens)
    putStrLn "Presione _ para\n(R)e-escolher personagens\nOu\n(C)ontinuar?"
    escolha <- getLine
    if escolha == "R" then menuBatalhaInicial
        else do
            system "clear"
            menuBatalha personagens


linkarEquipPerson :: Personagem -> Equipavel -> IO ()
linkarEquipPerson persng item = do
    let new_person = Persona.equiparItem item persng
    replacePersonOnFile new_person persng


linkarConsmvlPerson :: Personagem -> Consumivel -> IO ()
linkarConsmvlPerson persng item = do
    let new_person = Persona.guardarConsumivel item persng
    replacePersonOnFile new_person persng


linkarHabilPerson :: Personagem -> Habilidade -> IO ()
linkarHabilPerson old_person habilis = do
    let new_person = Persona.alocaHabilidade habilis old_person
    replacePersonOnFile new_person old_person


desalocarHabilPerson :: Personagem -> Habilidade -> IO ()
desalocarHabilPerson old_person habilis = do
    let new_person = Persona.desalocaHabilidade habilis old_person
    replacePersonOnFile new_person old_person

desalocarHabil :: IO ()
desalocarHabil = do
    system "clear"
    putStrLn "Qual o ID da Habilidade?"
    entrada <- getLine
    let id = read entrada :: Int
    contents <- readFile "data/habil.info"
    if (id >= (length(lines contents))) then putStrLn "Id Invalida" 
        else do
            let habilidade = (lines contents) !! id
            putStrLn "Qual o nome do Personagem?"
            nome <- getLine
            filePerson <- readFile "data/persngs.bd"
            let persngsString = lines filePerson
            let person = getPersng (transformaListaPersonagem persngsString) nome
            if (isNothing person) then putStrLn "Personagem Inexistente"
                else do
                    desalocarHabilPerson (fromJust person) (getHabilFromString habilidade)
    restart menuPersng


desequiparItemPerson :: IO ()
desequiparItemPerson = do
    system "clear"
    putStrLn "Qual o Tipo de Item Desejado?\n1 - Equipavel\nOu\n2 - Consumivel"
    tipo <- getLine
    if (tipo /= "1" && tipo /= "2") then putStrLn "Entrada Invalida"
        else do
            putStrLn "Qual o ID do Item?"
            entrada <- getLine
            let id = read entrada :: Int
            itemStr <- getFromTipo tipo
            if (id >= (length(lines itemStr))) then putStrLn "Id Invalida" 
                else do
                    let item = (lines itemStr) !! id
                    putStrLn "Qual o nome do Personagem?"
                    nome <- getLine
                    filePerson <- readFile "data/persngs.bd"
                    let persngsString = lines filePerson
                    let person = getPersng (transformaListaPersonagem persngsString) nome
                    if (isNothing person) then putStrLn "Personagem Inexistente"
                        else do
                            if (tipo == "1") then (desequiparEquipPerson (fromJust person) (getEquipavelFromString item))
                                else (desequiparConsmvlPerson (fromJust person) (getConsmvlFromString item))
    restart menuPersng


desequiparEquipPerson :: Personagem -> Equipavel -> IO ()
desequiparEquipPerson persng item = do
    let new_person = Persona.desequiparItem item persng
    replacePersonOnFile new_person persng


desequiparConsmvlPerson :: Personagem -> Consumivel -> IO ()
desequiparConsmvlPerson persng item = do
    let new_person = Persona.desequiparConsumivel item persng
    replacePersonOnFile new_person persng


getPersonagens :: [String] -> [Personagem] -> [Personagem]
getPersonagens [] _ = []
getPersonagens (x:xs) personagens
    | isNothing (getPersng personagens x) = (getPersonagens xs personagens)
    | otherwise = (fromJust(getPersng personagens x)):(getPersonagens xs personagens)


menuBatalha :: [Personagem] -> IO ()
menuBatalha personagens = do
    putStrLn "Qual sera a proxima acao?\n1 - Personagem Usar Habilidade\n2 - Personagem Usar Comsumivel\n3 - Checar Personagens\n9 - Limpar as mensagens anteriores\n0 - Encerrar a Batalha\n"
    opcao <- getLine
    let action = lookup opcao [("1", batalhaHabilis), ("2", batalhaConsmvl), ("3", checarPersons),("9", limparChat), ("0", encerramento)]
    verificaEntradaBatalha action personagens
    

checarPersons :: [Personagem] -> IO ()
checarPersons persons = do
    putStrLn $ unlines (printarPersonagens persons)
    menuBatalha persons


batalhaConsmvl :: [Personagem] -> IO ()
batalhaConsmvl personagens = do
    putStrLn "Qual dos Personagens usara o Consumivel? (Nome)"
    putStrLn (Persona.listarPersonagens personagens)
    nome <- getLine
    if not(isNothing (getPersng personagens nome)) then do
        putStrLn "Em Qual dos Personagens sera aplicado o Consumivel? (Nome)"
        putStrLn (Persona.listarPersonagens personagens)
        nome2 <- getLine
        if not((isNothing (getPersng personagens nome2)))
            then do
                putStrLn "Qual o ID do Consumivel que sera usado? (ID Geral)"
                entrada <- getLine
                let id = read entrada :: Int
                contents <- readFile "data/consmvl.info"
                let itens = lines contents
                if id < length itens
                    then do
                        let envolvidos = getPersonagens [nome, nome2] personagens 
                        let (s : xs) = Batalha.turnoConsumivel (head envolvidos) (last envolvidos) (getConsmvlFromString (itens !! id))
                        let (c : xc) = xs 
                        if(nome_personagem s /= nome_personagem c)
                            then do
                                putStrLn "Os Personagens agora estao assim:"
                                putStrLn $ Persona.exibePersonagemString s
                                putStrLn $ Persona.exibePersonagemString c
                                putStrLn "\nEnter para voltar a batalha"
                                restartBatalha menuBatalha ((Persona.atualizaPersonagem (Persona.atualizaPersonagem personagens s) c))
                            else do
                                putStrLn "O Personagem agora esta assim:"
                                putStrLn $ Persona.exibePersonagemString s
                                putStrLn "\nEnter para voltar a batalha"
                                restartBatalha menuBatalha (Persona.atualizaPersonagem personagens s)
                    else do
                        putStrLn "ID Invalido"
                        restartBatalha menuBatalha personagens
            else do
                putStrLn "Personagem Inexistente"
                restartBatalha menuBatalha personagens
        else do
            putStrLn "Personagem Inexistente"
            restartBatalha menuBatalha personagens


limparChat :: [Personagem] -> IO ()
limparChat personagens = do
    system "clear"
    menuBatalha personagens


batalhaHabilis :: [Personagem] -> IO ()
batalhaHabilis personagens = do
    putStrLn "Qual dos Personagens usara a Habilidade? (Nome)"
    putStrLn (Persona.listarPersonagens personagens)
    nome <- getLine
    if not((isNothing (getPersng personagens nome))) then do
        putStrLn "Em Qual dos Personagens sera aplicado a Habilidade? (Nome)"
        putStrLn (Persona.listarPersonagens personagens)
        nome2 <- getLine
        if not((isNothing (getPersng personagens nome2)))
            then do
                putStrLn "Qual o ID da habilidade que sera usada? (ID Geral)"
                entrada <- getLine
                let id = read entrada :: Int
                contents <- readFile "data/habil.info"
                let habilidades = lines contents
                if id < length habilidades
                    then do
                        let envolvidos = getPersonagens [nome, nome2] personagens
                        let habilidade = getHabilFromString (habilidades !! id)
                        random_gen <- newStdGen
                        let dados = take 2 (randomRs (1,20) random_gen)
                        putStrLn "Os Dados tirados Foram:"
                        putStrLn ((show (head dados)) ++ " - " ++ (show (last dados)))
                        putStrLn $ "A habilidade usada foi " ++ show(Habil.nome_habilidade habilidade)
                        putStrLn $ "Esta habilidade requer tirar " ++ show(Habil.pontosParaAcerto habilidade) ++ " pontos para acertar."
                        if tipoDeDano habilidade `elem` Persona.imunidades (last envolvidos) then
                          putStrLn "O receptor tem resistência ao tipo da habilidade. O dado de menor número será usado."
                        else
                          putStrLn "O receptor não tem resistência ao tipo da habilidade. O dado de maior número será usado."
                        putStrLn $ "O emissor tem " ++ show(Batalha.selecionaAtributoRelacionado (Habil.atributo_relacionado habilidade) (last envolvidos)) ++ " pontos do atributo relacionado à habilidade. Estes serão somados ao número do dado para o acerto.\n"
                        let newPerson = Batalha.turnoHabilidade (head envolvidos) (last envolvidos) habilidade (head dados) (last dados)
                        putStrLn "O receptor agora esta assim:"
                        putStrLn $ Persona.exibePersonagemString newPerson
                        putStrLn "\nEnter para voltar a batalha"

                        restartBatalha menuBatalha (Persona.atualizaPersonagem personagens newPerson)
                    else do
                        putStrLn "ID Invalido"
                        restartBatalha menuBatalha personagens
            else do
                putStrLn "Personagem Inexistente"
                restartBatalha menuBatalha personagens
        else do
            putStrLn "Personagem Inexistente"
            restartBatalha menuBatalha personagens

restartBatalha :: ([Personagem] -> IO ()) -> [Personagem] -> IO ()
restartBatalha battle personagens = do
    opcao <- getLine
    if opcao == "" then battle personagens else (restartBatalha battle personagens)


printarPersonagens :: [Personagem] -> [String]
printarPersonagens [] = []
printarPersonagens (p:ps) = (Persona.exibePersonagemString p):(printarPersonagens ps)


verificaEntradaBatalha :: Maybe ([Personagem] -> IO ()) -> ([Personagem] -> IO ())
verificaEntradaBatalha Nothing = (\ a -> putStrLn "\nEntrada Invalida brooo, vlw flw\n\nps. tuas alteracoees n foram salvas :(\n\n")
verificaEntradaBatalha (Just a) = a




encerramento :: [Personagem] -> IO ()
encerramento personagens = do
    putStrLn "Batalha Encerrada"
    let mortos = [p | p <- personagens, not (Batalha.taVivo p)]
    putStrLn "Os Personagens que morreram foram:\n"
    putStrLn $ Persona.listarPersonagens mortos
    let vivos = [p | p <- personagens, Batalha.taVivo p]
    putStrLn "\nOs Personagens que sobreviveram foram:\n"
    putStrLn $ Persona.listarPersonagens vivos
    putStrLn "\n\nQuais Personagens voce gostaria de resetar a vida para o maximo?"
    zumbis <- getMultipleLines
    putStrLn "Quais Personagens voce gostaria de apagar do sistema?"
    apagar <- getMultipleLines
    let pos_regeneracao = regenera personagens zumbis
    let personagens_finais = [ p | p <- pos_regeneracao, p `notElem` (getPersonagens apagar pos_regeneracao) ]
    -- (getPersonagens zumbis personagens)
    -- let personagens_finais = [p | p <- regenerados, p `notElem` (getPersonagens apagar regenerados)]
    writeFile "data/persngs.bd" (unlines(map show personagens_finais))
    putStrLn "\n\nAlteracoes Salvas\nRetornando ao Menu\n"

regenera :: [Personagem] -> [String] -> [Personagem]
regenera [] lista = []
regenera (p:ps) lista
  | Persona.nome_personagem p `elem` lista          = Persona.regeneraPersonagem p : regenera ps lista
  | otherwise                                       = p : regenera ps lista