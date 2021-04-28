import Personagem


aumentaXP :: Personagem -> Int -> Personagem
aumentaXP personagem quantidadeXP
  | xp personagem + quantidadeXP == xpUp personagem = upa personagem
  | xp personagem + quantidadeXP > xpUp personagem = aumentaXP (upa personagem) (xp personagem + quantidadeXP - xpUp personagem)
  | otherwise = Personagem {
      alcunha = alcunha personagem
      , raca = raca personagem
      , classe = classe personagem
      , vida = vida personagem
      , vidaMaxima = vidaMaxima personagem
      , forca = forca personagem
      , inteligencia = inteligencia personagem
      , sabedoria = sabedoria personagem
      , destreza = destreza personagem
      , constituicao = constituicao personagem
      , carisma = carisma personagem
      , dano = dano personagem
      , velocidade = velocidade personagem
      , ouro = ouro personagem
      , xp = xp personagem + quantidadeXP
      , xpUp = xpUp personagem
      , nivel = nivel personagem
      , equipaveis = equipaveis personagem
      , consumiveis = consumiveis personagem
      , habilidades = habilidades personagem
      }


upa :: Personagem -> Personagem
upa personagem = Personagem {
  alcunha = alcunha personagem
  , raca = raca personagem
  , classe = classe personagem
  , vida = vida personagem
  , vidaMaxima = vidaMaxima personagem
  , forca = forca personagem
  , inteligencia = inteligencia personagem
  , sabedoria = sabedoria personagem
  , destreza = destreza personagem
  , constituicao = constituicao personagem
  , carisma = carisma personagem
  , dano = dano personagem
  , velocidade = velocidade personagem
  , ouro = ouro personagem
  , xp = 0
  , xpUp = xpUp personagem
  , nivel = nivel personagem + 1
  , equipaveis = equipaveis personagem
  , consumiveis = consumiveis personagem
  , habilidades = habilidades personagem
  }


mudaXPUp :: Personagem -> Int -> Personagem
mudaXPUp personagem novoXPUp = Personagem {
  alcunha = alcunha personagem
  , raca = raca personagem
  , classe = classe personagem
  , vida = vida personagem
  , vidaMaxima = vidaMaxima personagem
  , forca = forca personagem
  , inteligencia = inteligencia personagem
  , sabedoria = sabedoria personagem
  , destreza = destreza personagem
  , constituicao = constituicao personagem
  , carisma = carisma personagem
  , dano = dano personagem
  , velocidade = velocidade personagem
  , ouro = ouro personagem
  , xp = xp personagem
  , xpUp = novoXPUp
  , nivel = nivel personagem
  , equipaveis = equipaveis personagem
  , consumiveis = consumiveis personagem
  , habilidades = habilidades personagem
  }


aumentaVidaMaxima :: Personagem -> Int -> Personagem
aumentaVidaMaxima personagem aumento = Personagem {
  alcunha = alcunha personagem
  , raca = raca personagem
  , classe = classe personagem
  , vida = vida personagem
  , vidaMaxima = vidaMaxima personagem + aumento
  , forca = forca personagem
  , inteligencia = inteligencia personagem
  , sabedoria = sabedoria personagem
  , destreza = destreza personagem
  , constituicao = constituicao personagem
  , carisma = carisma personagem
  , dano = dano personagem
  , velocidade = velocidade personagem
  , ouro = ouro personagem
  , xp = xp personagem
  , xpUp = xpUp personagem
  , nivel = nivel personagem
  , equipaveis = equipaveis personagem
  , consumiveis = consumiveis personagem
  , habilidades = habilidades personagem
  }


aumentaVelocidade :: Personagem -> Int -> Personagem
aumentaVelocidade personagem aumento = Personagem {
  alcunha = alcunha personagem
  , raca = raca personagem
  , classe = classe personagem
  , vida = vida personagem
  , vidaMaxima = vidaMaxima personagem
  , forca = forca personagem
  , inteligencia = inteligencia personagem
  , sabedoria = sabedoria personagem
  , destreza = destreza personagem
  , constituicao = constituicao personagem
  , carisma = carisma personagem
  , dano = dano personagem
  , velocidade = velocidade personagem + aumento
  , ouro = ouro personagem
  , xp = xp personagem
  , xpUp = xpUp personagem
  , nivel = nivel personagem
  , equipaveis = equipaveis personagem
  , consumiveis = consumiveis personagem
  , habilidades = habilidades personagem
  }


aumentaDano :: Personagem -> Int -> Personagem
aumentaDano personagem aumento = Personagem {
  alcunha = alcunha personagem
  , raca = raca personagem
  , classe = classe personagem
  , vida = vida personagem
  , vidaMaxima = vidaMaxima personagem
  , forca = forca personagem
  , inteligencia = inteligencia personagem
  , sabedoria = sabedoria personagem
  , destreza = destreza personagem
  , constituicao = constituicao personagem
  , carisma = carisma personagem
  , dano = dano personagem + aumento
  , velocidade = velocidade personagem
  , ouro = ouro personagem
  , xp = xp personagem
  , xpUp = xpUp personagem
  , nivel = nivel personagem
  , equipaveis = equipaveis personagem
  , consumiveis = consumiveis personagem
  , habilidades = habilidades personagem
  }


aumentaPontosAtributo :: String -> Int -> Personagem -> Personagem
aumentaPontosAtributo atributo pontos personagem
  | atributo == "forca" = aumentaForca personagem pontos
  | atributo == "inteligencia" = aumentaInteligencia personagem pontos
  | atributo == "sabedoria" = aumentaSabedoria personagem pontos
  | atributo == "destreza" = aumentaDestreza personagem pontos
  | atributo == "constituicao" = aumentaConstituicao personagem pontos
  | atributo == "carisma" = aumentaCarisma personagem pontos


aumentaForca :: Personagem -> Int -> Personagem
aumentaForca personagem pontos = Personagem {
  alcunha = alcunha personagem
  , raca = raca personagem
  , classe = classe personagem
  , vida = vida personagem
  , vidaMaxima = vidaMaxima personagem
  , forca = forca personagem + pontos
  , inteligencia = inteligencia personagem
  , sabedoria = sabedoria personagem
  , destreza = destreza personagem
  , constituicao = constituicao personagem
  , carisma = carisma personagem
  , dano = dano personagem
  , velocidade = velocidade personagem
  , ouro = ouro personagem
  , xp = xp personagem
  , xpUp = xpUp personagem
  , nivel = nivel personagem
  , equipaveis = equipaveis personagem
  , consumiveis = consumiveis personagem
  , habilidades = habilidades personagem
  }


aumentaInteligencia :: Personagem -> Int -> Personagem
aumentaInteligencia personagem pontos = Personagem {
  alcunha = alcunha personagem
  , raca = raca personagem
  , classe = classe personagem
  , vida = vida personagem
  , vidaMaxima = vidaMaxima personagem
  , forca = forca personagem
  , inteligencia = inteligencia personagem + pontos
  , sabedoria = sabedoria personagem
  , destreza = destreza personagem
  , constituicao = constituicao personagem
  , carisma = carisma personagem
  , dano = dano personagem
  , velocidade = velocidade personagem
  , ouro = ouro personagem
  , xp = xp personagem
  , xpUp = xpUp personagem
  , nivel = nivel personagem
  , equipaveis = equipaveis personagem
  , consumiveis = consumiveis personagem
  , habilidades = habilidades personagem
  }


aumentaSabedoria :: Personagem -> Int -> Personagem
aumentaSabedoria personagem pontos = Personagem {
  alcunha = alcunha personagem
  , raca = raca personagem
  , classe = classe personagem
  , vida = vida personagem
  , vidaMaxima = vidaMaxima personagem
  , forca = forca personagem
  , inteligencia = inteligencia personagem
  , sabedoria = sabedoria personagem + pontos
  , destreza = destreza personagem
  , constituicao = constituicao personagem
  , carisma = carisma personagem
  , dano = dano personagem
  , velocidade = velocidade personagem
  , ouro = ouro personagem
  , xp = xp personagem
  , xpUp = xpUp personagem
  , nivel = nivel personagem
  , equipaveis = equipaveis personagem
  , consumiveis = consumiveis personagem
  , habilidades = habilidades personagem
  }


aumentaDestreza :: Personagem -> Int -> Personagem
aumentaDestreza personagem pontos = Personagem {
  alcunha = alcunha personagem
  , raca = raca personagem
  , classe = classe personagem
  , vida = vida personagem
  , vidaMaxima = vidaMaxima personagem
  , forca = forca personagem
  , inteligencia = inteligencia personagem
  , sabedoria = sabedoria personagem
  , destreza = destreza personagem + pontos
  , constituicao = constituicao personagem
  , carisma = carisma personagem
  , dano = dano personagem
  , velocidade = velocidade personagem
  , ouro = ouro personagem
  , xp = xp personagem
  , xpUp = xpUp personagem
  , nivel = nivel personagem
  , equipaveis = equipaveis personagem
  , consumiveis = consumiveis personagem
  , habilidades = habilidades personagem
  }


aumentaConstituicao :: Personagem -> Int -> Personagem
aumentaConstituicao personagem pontos = Personagem {
  alcunha = alcunha personagem
  , raca = raca personagem
  , classe = classe personagem
  , vida = vida personagem
  , vidaMaxima = vidaMaxima personagem
  , forca = forca personagem
  , inteligencia = inteligencia personagem
  , sabedoria = sabedoria personagem
  , destreza = destreza personagem
  , constituicao = constituicao personagem + pontos
  , carisma = carisma personagem
  , dano = dano personagem
  , velocidade = velocidade personagem
  , ouro = ouro personagem
  , xp = xp personagem
  , xpUp = xpUp personagem
  , nivel = nivel personagem
  , equipaveis = equipaveis personagem
  , consumiveis = consumiveis personagem
  , habilidades = habilidades personagem
  }


aumentaCarisma :: Personagem -> Int -> Personagem
aumentaCarisma personagem pontos = Personagem {
  alcunha = alcunha personagem
  , raca = raca personagem
  , classe = classe personagem
  , vida = vida personagem
  , vidaMaxima = vidaMaxima personagem
  , forca = forca personagem
  , inteligencia = inteligencia personagem
  , sabedoria = sabedoria personagem
  , destreza = destreza personagem
  , constituicao = constituicao personagem
  , carisma = carisma personagem + pontos
  , dano = dano personagem
  , velocidade = velocidade personagem
  , ouro = ouro personagem
  , xp = xp personagem
  , xpUp = xpUp personagem
  , nivel = nivel personagem
  , equipaveis = equipaveis personagem
  , consumiveis = consumiveis personagem
  , habilidades = habilidades personagem
  }