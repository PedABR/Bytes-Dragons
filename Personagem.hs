module Personagem where
-- import System.Random
import Item

data Raca = Raca {
    nome_raca :: String
    ,mod_forca :: Int
    ,mod_inteligencia :: Int
    ,mod_sabedoria :: Int
    ,mod_destreza :: Int
    ,mod_constituicao :: Int
    ,mod_carisma :: Int
} deriving (Show, Eq, Read)

data Classe = Classe {
    nome_classe :: String
    -- to be continued
} deriving (Show, Eq, Read)

data Habilidade = Habilidade {
    nome_habilidade :: String,
    impacto_vida :: Int,
    impacto_dano :: Int,
    impacto_velocidade :: Int,
    atributo_relacionado :: String,
    pontosParaAcerto :: Int,
    tipoDeDano :: String
} deriving(Show, Eq, Read)

data Personagem = Personagem {
    nome_personagem :: String
    ,raca :: Raca
    ,classe :: Classe
    ,vida :: Int
    ,vidaMaxima :: Int
    ,forca :: Int
    ,inteligencia :: Int
    ,sabedoria :: Int
    ,destreza :: Int
    ,constituicao :: Int
    ,carisma :: Int
    ,dano :: Int
    ,velocidade :: Int
    ,ouro :: Int
    ,equipaveis :: [Equipavel]
    ,consumiveis :: [Consumivel]
    ,habilidades :: [Habilidade]
} deriving(Show, Eq, Read)

cadastraPersonagem :: String -> Classe -> Raca -> Int -> Int -> Int -> Int -> Int -> Int -> Int -> Personagem
cadastraPersonagem nome_personagem classe raca vidaMaxima forca inteligencia sabedoria destreza constituicao carisma = (Personagem {
                                                                                                                    nome_personagem = nome_personagem
                                                                                                                    ,vida = vidaMaxima
                                                                                                                    ,classe = classe
                                                                                                                    ,raca = raca
                                                                                                                    ,vidaMaxima = vidaMaxima
                                                                                                                    ,forca = forca + mod_forca raca
                                                                                                                    ,inteligencia = inteligencia + mod_inteligencia raca
                                                                                                                    ,sabedoria = sabedoria + mod_sabedoria raca
                                                                                                                    ,destreza = destreza + mod_destreza raca
                                                                                                                    ,constituicao = constituicao + mod_constituicao raca
                                                                                                                    ,carisma = carisma + mod_carisma raca
                                                                                                                    ,dano = forca
                                                                                                                    ,velocidade = destreza
                                                                                                                    ,ouro = 0
                                                                                                                    ,equipaveis = []
                                                                                                                    ,consumiveis = []
                                                                                                                    ,habilidades = []
                                                                                                                })


cadastraHabilidade :: String -> Int -> Int -> Int -> String -> Int -> String -> Habilidade
cadastraHabilidade nome impacto_vida impacto_dano impacto_velocidade atributo_relacionado pontosParaAcerto tipoDeDano = (Habilidade {
                                                                                                                            nome_habilidade = nome
                                                                                                                            ,impacto_vida = impacto_vida
                                                                                                                            ,impacto_dano = impacto_dano
                                                                                                                            ,impacto_velocidade = impacto_velocidade
                                                                                                                            ,atributo_relacionado = atributo_relacionado
                                                                                                                            ,pontosParaAcerto = pontosParaAcerto
                                                                                                                            ,tipoDeDano = tipoDeDano
                                                                                                                        })

listarPersonagens :: [Personagem] -> String
listarPersonagens [] = ""
listarPersonagens (s:xs) = "---------------------------\n"
                           ++ "Nome: " ++ show(nome_personagem s) ++ "\n"
                           ++ "Raca: " ++ show(raca s) ++ "\n"
                           ++ "Classe: " ++ show(classe s) ++ "\n"
                           ++ listarPersonagens xs

exibePersonagem :: [Personagem] -> String -> String
exibePersonagem [] nome = "Personagem inexistente"
exibePersonagem (s:xs) nome
    | nome == (nome_personagem s) = "Nome: " ++ show(nome_personagem s) ++ "\n"
                        ++ "Raca: " ++ show(raca s) ++ "\n"
                        ++ "Classe: " ++ show(classe s) ++ "\n"
                        ++ "Vida: " ++ show(vida s) ++ "/" ++ show(vidaMaxima s) ++ "\n"
                        ++ "Forca: " ++ show(forca s) ++ "\n"
                        ++ "Inteligencia: " ++ show(inteligencia s) ++ "\n"
                        ++ "Sabedoria: " ++ show(sabedoria s) ++ "\n"
                        ++ "Destreza: " ++ show(destreza s) ++ "\n"
                        ++ "Constituicao: " ++ show(constituicao s) ++ "\n"
                        ++ "Carisma: " ++ show(carisma s) ++ "\n"
                        ++ "Dano: " ++ show(dano s) ++ "\n"
                        ++ "Velocidade: " ++ show(velocidade s) ++ "\n"
                        ++ "Ouro: " ++ show(ouro s) ++ "\n"
                        ++ "Itens:\n"
                        ++ "Equipaveis:\n"
                        ++ (unlines (listarEquipaveis (equipaveis s)))
                        ++ "Consumiveis:\n"
                        ++ (unlines (listarConsumiveis (consumiveis s)))
                        ++ "Habilidades:\n"
                        ++ (unlines (listarHabilidades (habilidades s)))
    | otherwise = exibePersonagem xs nome

listarHabilidade :: Habilidade -> String
listarHabilidade habilidade = "---------------------------\n"
                           ++ "Nome: " ++ show(nome_habilidade habilidade) ++ "\n"
                           ++ if (impacto_vida habilidade /= 0) then "Causa " ++ show(impacto_dano habilidade) ++ " de dano do tipo " ++ show(tipoDeDano habilidade) ++ "\n" else ""
                           ++ if (impacto_dano habilidade /= 0) then "Causa " ++ show(impacto_dano habilidade) ++ " de dano no dano\n" else ""
                           ++ if (impacto_velocidade habilidade /= 0) then "Causa " ++ show(impacto_velocidade habilidade) ++ " de dano na velocidade\n" else ""
                           ++ "Pontos para acerto: " ++ show(pontosParaAcerto habilidade) ++ "%\n"

listarHabilidades :: [Habilidade] -> [String]
listarHabilidades [] = [""]
listarHabilidades (s:xs) = ("Nome: " ++ show(nome_habilidade s) ++ "\n"): listarHabilidades xs

equiparItem :: Equipavel -> Personagem -> Personagem
equiparItem equipavel personagem = 
    Personagem{nome_personagem = nome_personagem personagem
        ,raca = raca personagem
        ,classe = classe personagem
        ,vida = vida personagem
        ,vidaMaxima = vidaMaxima personagem
        ,forca = forca personagem
        ,inteligencia = inteligencia personagem
        ,sabedoria = sabedoria personagem
        ,destreza = destreza personagem
        ,constituicao = constituicao personagem
        ,carisma = carisma personagem
        ,dano = dano personagem
        ,velocidade = velocidade personagem + alteracaoVelocidadeEquipavel equipavel
        ,ouro = ouro personagem
        ,equipaveis = equipaveis personagem ++ [equipavel]
        ,consumiveis = consumiveis personagem
        ,habilidades = habilidades personagem
    }

guardarConsumivel :: Consumivel -> Personagem -> Personagem
guardarConsumivel item personagem =
    Personagem{nome_personagem = nome_personagem personagem
        ,raca = raca personagem
        ,classe = classe personagem
        ,vida = vida personagem
        ,vidaMaxima = vidaMaxima personagem
        ,forca = forca personagem
        ,inteligencia = inteligencia personagem
        ,sabedoria = sabedoria personagem
        ,destreza = destreza personagem
        ,constituicao = constituicao personagem
        ,carisma = carisma personagem
        ,dano = dano personagem
        ,velocidade = velocidade personagem
        ,ouro = ouro personagem
        ,equipaveis = equipaveis personagem
        ,consumiveis = consumiveis personagem ++ [item]
        ,habilidades = habilidades personagem
    }

removeItem :: Consumivel -> Personagem -> [Consumivel]
removeItem consumivel personagem
    | duracao consumivel /= 0 = [item | item <- consumiveis personagem, nomeConsumivel item /= nomeConsumivel consumivel] ++ [consumivel]
    | otherwise = [item | item <- consumiveis personagem, nomeConsumivel item /= nomeConsumivel consumivel]

usarItem :: Consumivel -> Personagem -> Personagem
usarItem consumivel personagem =
    Personagem{nome_personagem = nome_personagem personagem
        ,raca = raca personagem
        ,classe = classe personagem
        ,vida = vida personagem + alteracaoVida consumivel
        ,vidaMaxima = vidaMaxima personagem
        ,forca = forca personagem
        ,inteligencia = inteligencia personagem
        ,sabedoria = sabedoria personagem
        ,destreza = destreza personagem
        ,constituicao = constituicao personagem
        ,carisma = carisma personagem
        ,dano = dano personagem + alteracaoDano consumivel
        ,velocidade = velocidade personagem
        ,ouro = ouro personagem
        ,equipaveis = equipaveis personagem
        ,consumiveis = removeItem consumivel personagem
        ,habilidades = habilidades personagem
    }
