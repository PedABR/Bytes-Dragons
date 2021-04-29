module Personagem where
-- import System.Random
import Item
import Data.Maybe

data Raca = Raca {
    nome_raca :: String
    ,mod_vidaMaxima :: Int
    ,mod_forca :: Int
    ,mod_inteligencia :: Int
    ,mod_sabedoria :: Int
    ,mod_destreza :: Int
    ,mod_constituicao :: Int
    ,mod_carisma :: Int
} deriving (Show, Eq, Read)

data Classe = Classe {
    nome_classe :: String
    ,vidaMaxima_classe :: Int
    ,forca_classe :: Int
    ,inteligencia_classe :: Int
    ,sabedoria_classe :: Int
    ,destreza_classe :: Int
    ,constituicao_classe :: Int
    ,carisma_classe :: Int
    ,gold_classe :: Int
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
    ,velocidade :: Int
    ,ouro :: Int
    ,xp :: Int
    ,xpUp :: Int
    ,nivel :: Int
    ,equipaveis :: [Equipavel]
    ,consumiveis :: [Consumivel]
    ,habilidades :: [Habilidade]
} deriving(Show, Eq, Read)

cadastraPersonagem :: String -> Classe -> Raca -> Personagem
cadastraPersonagem nome_personagem classe raca = (Personagem {
                                                            nome_personagem = nome_personagem
                                                            ,raca = raca
                                                            ,classe = classe
                                                            ,vidaMaxima = vidaMaxima_classe classe + mod_vidaMaxima raca
                                                            ,vida = vidaMaxima_classe classe + mod_vidaMaxima raca
                                                            ,forca = forca_classe classe + mod_forca raca
                                                            ,inteligencia = inteligencia_classe classe + mod_inteligencia raca
                                                            ,sabedoria = sabedoria_classe classe + mod_sabedoria raca
                                                            ,destreza = destreza_classe classe+ mod_destreza raca
                                                            ,constituicao = constituicao_classe classe + mod_constituicao raca
                                                            ,carisma = carisma_classe classe + mod_carisma raca
                                                            ,velocidade = destreza_classe classe+ mod_destreza raca - (constituicao_classe classe + mod_constituicao raca)
                                                            ,ouro = gold_classe classe
                                                            ,xp = 0
                                                            ,xpUp = 1000
                                                            ,nivel = 1
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

exibePersonagem :: Personagem -> String
exibePersonagem personagem = "Nome: " ++ show(nome_personagem personagem) ++ "\n"
                        ++ "Raca: " ++ show(raca personagem) ++ "\n"
                        ++ "Classe: " ++ show(classe personagem) ++ "\n"
                        ++ "Vida: " ++ show(vida personagem) ++ "/" ++ show(vidaMaxima personagem) ++ "\n"
                        ++ "Forca: " ++ show(forca personagem) ++ "\n"
                        ++ "Inteligencia: " ++ show(inteligencia personagem) ++ "\n"
                        ++ "Sabedoria: " ++ show(sabedoria personagem) ++ "\n"
                        ++ "Destreza: " ++ show(destreza personagem) ++ "\n"
                        ++ "Constituicao: " ++ show(constituicao personagem) ++ "\n"
                        ++ "Carisma: " ++ show(carisma personagem) ++ "\n"
                        ++ "Velocidade: " ++ show(velocidade personagem) ++ "\n"
                        ++ "Ouro: " ++ show(ouro personagem) ++ "\n"
                        ++ "XP: " ++ show(xp personagem) ++ "/" ++ show(xpUp personagem) ++ "\n"
                        ++ "Nível: " ++ show(nivel personagem) ++ "\n"
                        ++ "Itens:\n"
                        ++ "Equipaveis:\n"
                        ++ (unlines (listarEquipaveis (equipaveis personagem)))
                        ++ "Consumiveis:\n"
                        ++ (unlines (listarConsumiveis (consumiveis personagem)))
                        ++ "Habilidades:\n"
                        ++ (unlines (listarHabilidades (habilidades personagem)))

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

selecionaAtributoRelacionado :: String -> Personagem -> Int
selecionaAtributoRelacionado atributo personagem
    | atributo == "forca" = forca personagem
    | atributo == "inteligencia" = inteligencia personagem
    | atributo == "sabedoria" = sabedoria personagem
    | atributo == "destreza" = destreza personagem
    | atributo == "constituicao" = constituicao personagem
    | atributo == "carisma" = carisma personagem
    | otherwise = 0

usaHabilidade :: Habilidade -> Personagem -> Personagem
usaHabilidade habilidade personagem =
    Personagem{nome_personagem = nome_personagem personagem
        ,raca = raca personagem
        ,classe = classe personagem
        ,vida = vida personagem + impacto_vida habilidade
        ,vidaMaxima = vidaMaxima personagem
        ,forca = forca personagem
        ,inteligencia = inteligencia personagem
        ,sabedoria = sabedoria personagem
        ,destreza = destreza personagem
        ,constituicao = constituicao personagem
        ,carisma = carisma personagem
        ,velocidade = velocidade personagem + impacto_velocidade habilidade
        ,ouro = ouro personagem
        ,xp = xp personagem
        ,xpUp = xpUp personagem
        ,nivel = nivel personagem
        ,equipaveis = equipaveis personagem
        ,consumiveis = consumiveis personagem
        ,habilidades = habilidades personagem
    }

isEquipavel :: [Equipavel] -> TipoEquipavel -> Maybe(Equipavel)
isEquipavel [] _ = Nothing
isEquipavel (x:xs) tipo = if(tipoEquipavel x == tipo) then (Just x) 
                          else isEquipavel xs tipo

usarItemEquipavel :: Equipavel -> Personagem -> Personagem
usarItemEquipavel equipavel personagem = equiparItem equipavel (desequiparItem equipavel personagem)


desequiparItem :: Equipavel -> Personagem -> Personagem
desequiparItem equipavel personagem = if (isNothing (isEquipavel (equipaveis personagem) (tipoEquipavel equipavel))) then personagem
                                      else  Personagem{ nome_personagem = nome_personagem personagem
                                                        ,raca = raca personagem
                                                        ,classe = classe personagem
                                                        ,vida = vida personagem
                                                        ,vidaMaxima = vidaMaxima personagem - alteracaoVidaMaxima equipavel
                                                        ,forca = forca personagem - alteracaoForca equipavel
                                                        ,inteligencia = inteligencia personagem - alteracaoInteligencia equipavel
                                                        ,sabedoria = sabedoria personagem - alteracaoSabedoria equipavel
                                                        ,destreza = destreza personagem - alteracaoDestreza equipavel
                                                        ,constituicao = constituicao personagem - alteracaoConstituicao equipavel
                                                        ,carisma = carisma personagem - alteracaoCarisma equipavel
                                                        ,velocidade = velocidade personagem - alteracaoVelocidadeEquipavel equipavel
                                                        ,ouro = ouro personagem
                                                        ,xp = xp personagem
                                                        ,xpUp = xpUp personagem
                                                        ,nivel = nivel personagem
                                                        ,equipaveis = removerEquipavel (equipaveis personagem) equipavel
                                                        ,consumiveis = consumiveis personagem
                                                        ,habilidades = habilidades personagem
                                                    } 

equiparItem :: Equipavel -> Personagem -> Personagem
equiparItem equipavel personagem = 
    
    Personagem{nome_personagem = nome_personagem personagem
        ,raca = raca personagem
        ,classe = classe personagem
        ,vida = vida personagem
        ,vidaMaxima = vidaMaxima personagem + alteracaoVidaMaxima equipavel
        ,forca = forca personagem + alteracaoForca equipavel
        ,inteligencia = inteligencia personagem + alteracaoInteligencia equipavel
        ,sabedoria = sabedoria personagem + alteracaoSabedoria equipavel
        ,destreza = destreza personagem + alteracaoDestreza equipavel
        ,constituicao = constituicao personagem + alteracaoConstituicao equipavel
        ,carisma = carisma personagem + alteracaoCarisma equipavel
        ,velocidade = velocidade personagem + alteracaoVelocidadeEquipavel equipavel
        ,ouro = ouro personagem
        ,xp = xp personagem
        ,xpUp = xpUp personagem
        ,nivel = nivel personagem
        ,equipaveis = equipaveis personagem ++ [equipavel]
        ,consumiveis = consumiveis personagem
        ,habilidades = habilidades personagem
    }

removerEquipavel :: [Equipavel] -> Equipavel -> [Equipavel]
removerEquipavel equipaveis equipavel = [x | x <- equipaveis, tipoEquipavel equipavel /= tipoEquipavel x]

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
        ,velocidade = velocidade personagem
        ,ouro = ouro personagem
        ,xp = xp personagem
        ,xpUp = xpUp personagem
        ,nivel = nivel personagem
        ,equipaveis = equipaveis personagem
        ,consumiveis = consumiveis personagem ++ [item]
        ,habilidades = habilidades personagem
    }

removeConsumivel :: Consumivel -> Personagem -> [Consumivel]
removeConsumivel consumivel personagem
    | (duracao consumivel) - 1 /= 0 = [item | item <- consumiveis personagem, item /= consumivel] ++ [reduzDuracao consumivel]
    | otherwise = [item | item <- consumiveis personagem, item /= consumivel]

reduzDuracao :: Consumivel -> Consumivel
reduzDuracao consumivel =
    Consumivel {nomeConsumivel = nomeConsumivel consumivel
        , alteracaoVida = alteracaoVida consumivel
        , alteracaoDano = alteracaoDano consumivel
        , alteracaoVelocidadeConsumivel = alteracaoVelocidadeConsumivel consumivel
        , duracao = duracao consumivel - 1
    }

usarItemConsumivel :: Consumivel -> Personagem -> Personagem
usarItemConsumivel consumivel personagem =
    Personagem{nome_personagem = nome_personagem personagem
        ,raca = raca personagem
        ,classe = classe personagem
        ,vida = cura (vida personagem) (vidaMaxima personagem) (alteracaoVida consumivel)
        ,vidaMaxima = vidaMaxima personagem
        ,forca = forca personagem
        ,inteligencia = inteligencia personagem
        ,sabedoria = sabedoria personagem
        ,destreza = destreza personagem
        ,constituicao = constituicao personagem
        ,carisma = carisma personagem
        ,velocidade = velocidade personagem + alteracaoVelocidadeConsumivel consumivel
        ,ouro = ouro personagem
        ,xp = xp personagem
        ,xpUp = xpUp personagem
        ,nivel = nivel personagem
        ,equipaveis = equipaveis personagem
        ,consumiveis = removeConsumivel consumivel personagem
        ,habilidades = habilidades personagem
    }

cura :: Int -> Int -> Int -> Int
cura atual maximo alteracao | atual + alteracao >= maximo = maximo
                            | otherwise = atual + alteracao
