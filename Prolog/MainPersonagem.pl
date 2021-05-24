:- include('Personagem.pl').

menuPersg :-
    write('\e[H\e[2J'),
    writeln(  '  ,   A           {}'),
    writeln(  ' / \\, | ,        .--.'),
    writeln(  '|    =|= >      /.--.\\ '),
    writeln(  ' \\ /` | `       |====|'),
    writeln(  '  `   |         |`::`| ' ),
    writeln(  '      |     .-;`\\..../`;_.-^-._'),
    writeln(  '     /\\ \\/ /  |...::..|`   :   `|'),
    writeln(  '     |:\'\\ |   /\'\'\'::\'\'|   .:.   |'),
    writeln(  '      \\ /\\;-,/\\.  ::  |..:::::..|'),
    writeln(  '      |\\ <` >  >._::_.| \':::::\' |'),
    writeln(  '      | `""`  /   ^^  |   \':\'   |'),
    writeln(  '      |       |       \\    :    /'),
    writeln(  '      |       |        \\   :   /' ),
    writeln(  '      |       |___/\\___|`-.:.-`'),
    writeln(  '      |        \\_ || _/    `'),
    writeln(  '      |        <_ >< _>'),
    writeln(  '      |        |  ||  |'),
    writeln(  '      |        |  ||  |'),
    writeln(  '      |       _\\.:||:./_'),
    writeln(  '      | jgs  /____/\\____\\'),
    writeln(  '1 - Listar Personagens\n2 - Criar Personagem\n3 - Detalhes de Personagem\n4 - Excluir Personagem\n5 - Menu de Relacao Item/Habilidade com Personagem\n6 - Especificar Resistencias\n7 - Inicar Batalha entre Personagens\n9 - Voltar Menu\n'),
    readEntrada(Entrada),
    menuPersg(Entrada).


menuPersg("1") :-
    writeln('Personagens: '),
    listarPersonagens,
    readEntrada(_),
    menuPersg.

menuPersg("2") :-
    nl, writeln('Qual o Nome do Personagem?'),
    readEntrada(Nome),
    writeln('Qual a Classe do Personagem?'),
    readEntrada(Classe),
    checkClasse(Classe),
    writeln('Qual a Raca do Personagem?'),
    readEntrada(Raca),
    checkRaca(Raca),
    constroiPersonagem(Nome, Classe, Raca),
    menuPersg.    

menuPersg("3") :-
    writeln('Qual o Nome do Personagem desejado?'),
    readEntrada(Nome),
    exibePersonagem(Nome),
    readEntrada(_), menuPersg.

menuPersg("4") :-
    writeln('Qual o Nome do Personagem a ser deletado?'),
    readEntrada(Nome),
    personagemExiste(Nome),
    retract_personagem(Nome, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _),
    write('Personagem deletado'),
    readEntrada(_), menuPersg.

menuPersg("5") :-
    menuItemPersonagem,
    menuPersg.

menuPersg("6") :-
    writeln('Qual a Resistencia? (Cortante | Magico | Venenoso | Fogo | Gelo | Fisico)'),
    readEntrada(Tipo),
    writeln('Qual o Nome do Personagem?'),
    readEntrada(Nome),
    personagemExiste(Nome),
    assert_resistencia(Nome, Tipo).


menuPersg("7") :-
    menuBatalha,
    menuPersg.


menuPersg("9").

menuPersg(_):-
    menuPersg.


constroiPersonagem(Nome, Classe, Raca) :-
    retract_personagem(Nome, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _),
    criaPersonagem(Nome, Classe, Raca).
constroiPersonagem(Nome, Classe, Raca) :-
    criaPersonagem(Nome, Classe, Raca).



checkRaca(Raca):-
    isRaca(Raca).
checkRaca(R):-
    string_concat(R, ' nao eh uma raca valida', S),
    writeln(S),!,
    false.


checkClasse(Classe):-
    isClasse(Classe).
checkClasse(C) :-
    string_concat(C, ' nao eh uma classe valida', S),
    writeln(S),!,
    false.


menuItemPersonagem :-
    write('\e[H\e[2J'),
    writeln(  '  ,   A           {}'),
    writeln(  ' / \\, | ,        .--.'),
    writeln(  '|    =|= >      /.--.\\ '),
    writeln(  ' \\ /` | `       |====|'),
    writeln(  '  `   |         |`::`| ' ),
    writeln(  '      |     .-;`\\..../`;_.-^-._'),
    writeln(  '     /\\ \\/ /  |...::..|`   :   `|'),
    writeln(  '     |:\'\\ |   /\'\'\'::\'\'|   .:.   |'),
    writeln(  '      \\ /\\;-,/\\.  ::  |..:::::..|'),
    writeln(  '      |\\ <` >  >._::_.| \':::::\' |'),
    writeln(  '      | `""`  /   ^^  |   \':\'   |'),
    writeln(  '      |       |       \\    :    /'),
    writeln(  '      |       |        \\   :   /' ),
    writeln(  '      |       |___/\\___|`-.:.-`'),
    writeln(  '      |        \\_ || _/    `'),
    writeln(  '      |        <_ >< _>'),
    writeln(  '      |        |  ||  |'),
    writeln(  '      |        |  ||  |'),
    writeln(  '      |       _\\.:||:./_'),
    writeln(  '      | jgs  /____/\\____\\'),
    writeln(  '1 - Equipar Item\n2 - Equipar Consumivel\n3 - Alocar Habilidade\n4 - Desequipar Item\n5 - Desequipar Consumivel\n6 - Desalocar Habilidade\n9 - Voltar Menu\n'),
    readEntrada(Entrada),
    menuItemPersonagem(Entrada).

menuItemPersonagem("1"):-
    nl, writeln('Qual o nome do Personagem?'),
    readEntrada(Nome),
    personagemExiste(Nome),
    writeln('Qual o nome do Equipavel?'),
    readEntrada(Equipavel),
    equipavelExiste(Equipavel),
    colocaItemPersonagem(Nome, Equipavel),
    menuItemPersonagem.

menuItemPersonagem("2") :-
    nl, writeln('Qual o nome do Personagem?'),
    readEntrada(Nome),
    personagemExiste(Nome),
    writeln('Qual o nome do Consumivel?'),
    readEntrada(Consumivel),
    consumivelExiste(Consumivel),
    colocaConsumivelPersonagem(Nome, Consumivel),
    menuItemPersonagem.

menuItemPersonagem("3") :-
    nl, writeln('Qual o nome do Personagem?'),
    readEntrada(Nome),
    personagemExiste(Nome),
    writeln('Qual o nome da Habilidade?'),
    readEntrada(Habilidade),
    habilidadeExiste(Habilidade),
    colocaHabilidadePersonagem(Nome, Habilidade),
    menuItemPersonagem.

menuItemPersonagem("4") :-
    nl, writeln('Qual o nome do Personagem?'),
    readEntrada(Nome),
    personagemExiste(Nome),
    writeln('Qual o nome da Equipavel?'),
    readEntrada(Equipavel),
    equipavelExiste(Equipavel),
    tiraEquipavelPersonagem(Nome, Equipavel),
    menuItemPersonagem.

menuItemPersonagem("5") :-
    nl, writeln('Qual o nome do Personagem?'),
    readEntrada(Nome),
    personagemExiste(Nome),
    writeln('Qual o nome da Consumivel?'),
    readEntrada(Consumivel),
    consumivelExiste(Consumivel),
    tiraConsumivelPersonagem(Nome, Consumivel),
    menuItemPersonagem.

menuItemPersonagem("6") :-
    nl, writeln('Qual o nome do Personagem?'),
    readEntrada(Nome),
    personagemExiste(Nome),
    writeln('Qual o nome da Habilidade?'),
    readEntrada(Habilidade),
    habilidadeExiste(Habilidade),
    tiraHabilidadePersonagem(Nome, Habilidade),
    menuItemPersonagem.

menuItemPersonagem("9").

menuItemPersonagem(_):-
    write('\nEntrada invalida.'),
    menuItemPersonagem.


colocaHabilidadePersonagem(Nome, Habilidade) :-
    retract_personagemTemHabilidade(Nome, Habilidade),
    assert_personagemTemHabilidade(Nome, Habilidade).

colocaHabilidadePersonagem(Nome, Habilidade) :-
    assert_personagemTemHabilidade(Nome, Habilidade).

colocaConsumivelPersonagem(Nome, Consumivel) :-
    retract_personagemTemConsumivel(Nome, Consumivel),
    assert_personagemTemConsumivel(Nome, Consumivel).

colocaConsumivelPersonagem(Nome, Consumivel) :-
    assert_personagemTemConsumivel(Nome, Consumivel).

colocaEquipavelPersonagem(Nome, Equipavel) :-
    retract_personagemTemEquipavel(Nome, Equipavel),
    assert_personagemTemEquipavel(Nome, Equipavel).

colocaEquipavelPersonagem(Nome, Equipavel) :-
    assert_personagemTemEquipavel(Nome, Equipavel).

tiraEquipavelPersonagem(Nome, Equipavel).
    retract_personagemTemEquipavel(Nome, Equipavel).
tiraEquipavelPersonagem(_, _).

tiraConsumivelPersonagem(Nome, Consumivel).
    retract_personagemTemConsumivel(Nome, Consumivel).
tiraConsumivelPersonagem(_, _).

tiraHabilidadePersonagem(Nome, Habilidade).
    retract_personagemTemHabilidade(Nome, Habilidade).
tiraHabilidadePersonagem(_, _).

personagemExiste(Nome) :-
    personagem(Nome, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _).

consumivelExiste(Nome) :-
    consumivel(Nome, _, _, _).

habilidadeExiste(Nome) :-
    habilidade(Nome, _, _, _, _, _).

equipavelExiste(Nome) :-
    equipavel(Nome, _, _, _, _, _, _, _, _, _).