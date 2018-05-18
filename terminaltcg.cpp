/* Terminal TCG;
  Adiel Andrade, Felipe Emerson, João Marcos e Raimundo Heitor;
  APLP 2018-1
*/

#include <iostream>
#include <string>
#include <time.h>
#include <stdlib.h>

using namespace std;

// ####### ESTRUTURAS #######

struct CartaStr {
  string nome;
  short vida;
  short ataque;
  string ataqueEspecial;
  bool atacarBool;
}reiDaMontanha, loboCeleste, espectroNegro,fortex, ogroNegro,mercurioAlado,
cortanaAAntipatica, ciriAEngracada, dellOFort, HPn01, Javas, CPlusivel,
 AntonelaASereia, NokiaTijolao, ZeDaPeixeira, MosntroDonATAL, ogroAlbino, deadLine, cartaNula;

struct JogadorStr {
  string nome;
  short vida;
  CartaStr *cartasMao[3];
  bool turno;
  bool jogarCartaBool;
} jogador1, jogador2;

struct TabuleiroStr {
  CartaStr *cartasJogador1[3];
  CartaStr *cartasJogador2[3];
} tabuleiro;

// ####### FUNCOES #######

// Imprime o tabuleiro
void imprimeTabuleiro(){
  std::cout << "----------------Tabuleiro: Jogador 1----------" << '\n';
  for (size_t i = 0; i < 3; i++) {
    std::cout << "Carta " << i+1 << ": Nome: "<< tabuleiro.cartasJogador1[i] -> nome << " ";
    std::cout << "Ataque: " << tabuleiro.cartasJogador1[i] -> ataque << " ";
    std::cout << "Vida: " << tabuleiro.cartasJogador1[i] -> vida << " ";
    std::cout << "Poder: " << tabuleiro.cartasJogador1[i] -> ataqueEspecial << '\n';
    std::cout << "" << '\n';
  }
  std::cout << "----------------Tabuleiro: Jogador 2----------" << '\n';
  for (size_t i = 0; i < 3; i++) {
    std::cout << "Carta " << i+1 << ": Nome: " << tabuleiro.cartasJogador2[i] -> nome << " ";
    std::cout << "Ataque: " << tabuleiro.cartasJogador2[i] -> ataque << " ";
    std::cout << "Vida: " << tabuleiro.cartasJogador2[i] -> vida << " ";
    std::cout << "Poder: " << tabuleiro.cartasJogador2[i] -> ataqueEspecial << '\n';
    std::cout << "" << '\n';
  }
}
//Imprime o topo
void topo(){
  // Tabuleiro para o jogador 1
  std::cout << "-----------------------------------------" << '\n';
  std::cout << "Vida Jogador 1= " << jogador1.vida << " | ";
  std::cout << "Vida Jogador 2= " << jogador2.vida << " |" << '\n';
}

void maoJogador1(){
  std::cout << "---------------Mao: Jogador 1---------------" << '\n';
  for(size_t i = 0; i < 3; i++){
      std::cout << "Carta " << i+1 << ": " << "Nome: "<< jogador1.cartasMao[i] -> nome << " ";
      std::cout << "Ataque " <<": "<< jogador1.cartasMao[i] -> ataque << " ";
      std::cout << "Vida " << ": "<< jogador1.cartasMao[i] -> vida << " ";
      std::cout << "Poder " <<  ": " << jogador1.cartasMao[i] -> ataqueEspecial << " ";
      std::cout << "" << '\n';
  }
  std::cout << "-------------------------------------------" << '\n';
}

void maoJogador2(){
  std::cout << "---------------Mao: Jogador 2---------------" << '\n';
  for(size_t i = 0; i < 3; i++){
      std::cout << "Carta " << i+1 << ": " << "Nome: "<< jogador2.cartasMao[i] -> nome << " ";
      std::cout << "Ataque " <<": "<< jogador2.cartasMao[i] -> ataque << " ";
      std::cout << "Vida " << ": "<< jogador2.cartasMao[i] -> vida << " ";
      std::cout << "Poder " << ": " << jogador2.cartasMao[i] -> ataqueEspecial << " ";
      std::cout << "" << '\n';
  }
  std::cout << "-------------------------------------------" << '\n';
}

//view principal
void vista(){
  system("clear");
  system("cls");
  topo();
  imprimeTabuleiro();
}


// Imprime a mao do jogador 1

void telaJogador1(std::string erro){
  vista();
  maoJogador1();
  std::cout << "Turno: Jogador 1:" << '\n';
  std::cout << "Menssagem: " << erro << '\n';
  std::cout << "JC - Jogar Carta | AJ - Atacar Jogador | AC - Atacar Carta | FT - Finalizar Turno" << '\n';

}

void telaJogador2(std::string erro){
  vista();
  maoJogador2();
  std::cout << "Turno: Jogador 2:" << '\n';
  std::cout << "Menssagem: " << erro << '\n';
  std::cout << "JC - Jogar Carta | AJ - Atacar Jogador | AC - Atacar Carta | FT - Finalizar Turno" << '\n';
}






//Verifica se o jogador inimigo tem alguma carta com Provocar.
bool verificaProvocar(int jogador) {
  if (jogador == 1) {
    for (size_t i = 0; i < 3; i++) {
      if (tabuleiro.cartasJogador1[i] -> ataqueEspecial.compare("Provocar") == 0) {
        return true;
      }
    }
  } else if (jogador == 2) {
    for (size_t i = 0; i < 3; i++) {
      if (tabuleiro.cartasJogador2[i] -> ataqueEspecial.compare("Provocar") == 0) {
        return true;
      }
    }
  }
  return false;
}

// Usa carta para atacar o jogador adversario.
void atacarJogadorInimigo(int jogador){
  int cartaOpt;
  std::cout << "Escolha uma carta sua para atacar (1, 2 ou 3)" << '\n';
  cin >> cartaOpt;

  if (jogador == 1 && verificaProvocar(2)) {
    telaJogador1("Alguma carta inimiga impediu seu ataque.");
  }
  if (jogador == 2 && verificaProvocar(1)) {
    telaJogador2("Alguma carta inimiga impediu seu ataque.");
  }

  if (jogador == 1 && !(tabuleiro.cartasJogador1[cartaOpt-1] -> atacarBool)) {
    telaJogador1("Voce nao pode atacar com essa carta agora.");
  }
  if (jogador == 2 && !(tabuleiro.cartasJogador2[cartaOpt-1] -> atacarBool)) {
    telaJogador2("Voce nao pode atacar com essa carta agora.");
  }

  if (jogador == 1 && tabuleiro.cartasJogador1[cartaOpt-1] -> nome.compare(cartaNula.nome) != 0 &&
      tabuleiro.cartasJogador1[cartaOpt-1] -> atacarBool && !verificaProvocar(2)) {
    jogador2.vida -= tabuleiro.cartasJogador1[cartaOpt-1] -> ataque;
    if (tabuleiro.cartasJogador1[cartaOpt-1] -> ataqueEspecial.compare("Ataque Duplo") == 0) {
      jogador2.vida -= tabuleiro.cartasJogador1[cartaOpt-1] -> ataque;
    }
    tabuleiro.cartasJogador1[cartaOpt-1] -> atacarBool = false;
    telaJogador1("A carta " + (tabuleiro.cartasJogador1[cartaOpt-1] -> nome) + " atacou o jogador 2");
  } else if (jogador == 2 && tabuleiro.cartasJogador2[cartaOpt-1] -> nome.compare(cartaNula.nome) != 0 &&
              tabuleiro.cartasJogador2[cartaOpt-1] -> atacarBool && !verificaProvocar(1)) {
    jogador1.vida -= tabuleiro.cartasJogador2[cartaOpt-1] -> ataque;
    if (tabuleiro.cartasJogador2[cartaOpt-1] -> ataqueEspecial.compare("Ataque Duplo") == 0) {
      jogador1.vida -= tabuleiro.cartasJogador2[cartaOpt-1] -> ataque;
    }
    tabuleiro.cartasJogador2[cartaOpt-1] -> atacarBool = false;
    telaJogador2("A carta " + (tabuleiro.cartasJogador2[cartaOpt-1] -> nome) + " atacou o jogador 1");
  }

  if ((jogador == 1 && tabuleiro.cartasJogador1[cartaOpt-1] -> nome.compare(cartaNula.nome) == 0) || (cartaOpt < 0 || cartaOpt > 3)) {
    telaJogador1("Carta nao existe.");
  }
  if ((jogador == 2 && tabuleiro.cartasJogador2[cartaOpt-1] -> nome.compare(cartaNula.nome) == 0) || (cartaOpt < 0 || cartaOpt > 3)) {
    telaJogador2("Carta nao existe.");
  }
}

// Usa uma carta do jogador para atacar uma carta adversaria.
void atacarCartaInimiga(int jogador){
  int cartaOpt;
  int cartaIni;
  std::cout << "Escolha uma carta sua para atacar (1, 2 ou 3)" << '\n';
  cin >> cartaOpt;
  std::cout << "Escolha uma carta inimiga para atacar (1, 2 ou 3)" << '\n';
  cin >> cartaIni;

  if (jogador == 1 && !(tabuleiro.cartasJogador1[cartaOpt-1] -> atacarBool)) {
    telaJogador1("Voce nao pode atacar com essa carta agora.");
  }
  if (jogador == 2 && !(tabuleiro.cartasJogador2[cartaOpt-1] -> atacarBool)) {
    telaJogador2("Voce nao pode atacar com essa carta agora.");
  }

  if (jogador == 1 && tabuleiro.cartasJogador1[cartaOpt-1] -> nome.compare(cartaNula.nome) != 0 &&
      tabuleiro.cartasJogador2[cartaIni-1] -> nome.compare(cartaNula.nome) != 0 && tabuleiro.cartasJogador1[cartaOpt-1] -> atacarBool) {
    tabuleiro.cartasJogador2[cartaIni-1] -> vida -= tabuleiro.cartasJogador1[cartaOpt-1] -> ataque;
    tabuleiro.cartasJogador1[cartaOpt-1] -> atacarBool = false;
    if (tabuleiro.cartasJogador1[cartaOpt-1] -> ataqueEspecial.compare("Ataque Duplo") == 0) {
      tabuleiro.cartasJogador2[cartaIni-1] -> vida -= tabuleiro.cartasJogador1[cartaOpt-1] -> ataque;
    }
    telaJogador1("A carta " + (tabuleiro.cartasJogador1[cartaOpt-1] -> nome) + " atacou a carta " + (tabuleiro.cartasJogador2[cartaIni-1] -> nome) );
    if (tabuleiro.cartasJogador2[cartaIni-1] -> vida <= 0) {
      tabuleiro.cartasJogador2[cartaIni-1] = &cartaNula;
    }
  } else if (jogador == 2 && tabuleiro.cartasJogador2[cartaOpt-1] -> nome.compare(cartaNula.nome) != 0 &&
            tabuleiro.cartasJogador1[cartaIni-1] -> nome.compare(cartaNula.nome) != 0 && tabuleiro.cartasJogador2[cartaOpt-1] -> atacarBool) {
    tabuleiro.cartasJogador1[cartaIni-1] -> vida -= tabuleiro.cartasJogador2[cartaOpt-1] -> ataque;
    if (tabuleiro.cartasJogador2[cartaOpt-1] -> ataqueEspecial.compare("Ataque Duplo") == 0) {
      tabuleiro.cartasJogador1[cartaIni-1] -> vida -= tabuleiro.cartasJogador2[cartaOpt-1] -> ataque;
    }
    tabuleiro.cartasJogador2[cartaOpt-1] -> atacarBool = false;
    telaJogador2("A carta " + (tabuleiro.cartasJogador2[cartaOpt-1] -> nome) + " atacou a carta " + (tabuleiro.cartasJogador1[cartaIni-1] -> nome) );
    if (tabuleiro.cartasJogador1[cartaIni-1] -> vida <= 0) {
      tabuleiro.cartasJogador1[cartaIni-1] = &cartaNula;
    }
  }

  if ((jogador == 1 && tabuleiro.cartasJogador1[cartaIni-1] -> nome.compare(cartaNula.nome) == 0) || (cartaOpt < 0 || cartaOpt > 3)) {
    telaJogador1("Carta nao existe.");
  }
  if ((jogador == 2 && tabuleiro.cartasJogador2[cartaIni-1] -> nome.compare(cartaNula.nome) == 0) || (cartaOpt < 0 || cartaOpt > 3)) {
    telaJogador2("Carta nao existe.");
  }

}

//Verifica se o campo do jogador esta vazio
bool campoDoJogadorEstaVazio(int jogador){
	for(size_t i = 0; i < 3; i++){
		if(jogador == (int) 1){
			if(tabuleiro.cartasJogador1[i] -> nome.compare(cartaNula.nome) != 0){
				return false;
			}
		}else if(jogador == (int) 2){
			if(tabuleiro.cartasJogador2[i] -> nome.compare(cartaNula.nome) != 0){
				return false;
			}
		}
	}
	return true;
}

//Verifica se o campo do jogador esta cheio
bool campoDoJogadorEstaCheio(int jogador){
	for(size_t i = 0; i < 3; i++){
		if(jogador == (int) 1){
			if(tabuleiro.cartasJogador1[i] -> nome.compare(cartaNula.nome) == 0){
				return false;
			}
		}else if(jogador == (int) 2){
			if(tabuleiro.cartasJogador2[i] -> nome.compare(cartaNula.nome) == 0){
				return false;
			}
		}

	}

	return true;
}

// Retonra uma posicao vazia no tabuleiro do jogador.
int getPosicaoVaziaNoCampo(int jogador){

	if (jogador == (int) 1) { //retorna posicao vazia para o jogador 1
		for(size_t i = 0; i < 3; i++){
			if(tabuleiro.cartasJogador1[i] -> nome.compare(cartaNula.nome) == 0){
				return i;
			}
		}
	} else if (jogador == (int) 2) { //retorna posicao vazia para o jogador 2
		for(size_t i = 0; i < 3; i++){
			if(tabuleiro.cartasJogador2[i] -> nome.compare(cartaNula.nome) == 0){
				return i;
			}
		}
	}

	return 0;
}

//Recebe o jogador que vai jogar uma carta e realiza a jogada
void jogarUmaCarta(int jogador) {
	string opcao;
	std::cout << "Escolha a carta a jogar (1, 2 ou 3)" << '\n';
	getline(cin, opcao);

	switch(atoi(opcao.c_str())){
		case 1: //Jogar a carta da primeira posicao
			if(jogador == (int) 1){
				if((jogador1.cartasMao[0] -> nome.compare(cartaNula.nome) != 0)){ //se a carta na posicao zero nao � a carta nula
					tabuleiro.cartasJogador1[getPosicaoVaziaNoCampo(jogador)] = jogador1.cartasMao[0];
          tabuleiro.cartasJogador1[0] -> atacarBool = false;
          if (tabuleiro.cartasJogador1[0] -> ataqueEspecial.compare("Iniciativa") == 0) {
            tabuleiro.cartasJogador1[0] -> atacarBool = true;
          }
					std::cout << "O Jogador 1 invocou o(a) " << jogador1.cartasMao[0] -> nome << '\n';
					jogador1.cartasMao[0] = &cartaNula;
				} else {
					std::cout << "Tabuleiro Cheio." << '\n';
				}
			} else if(jogador == (int) 2){
				if((jogador2.cartasMao[0] -> nome.compare(cartaNula.nome) != 0)){ //se a carta na posicao zero nao � a carta nula
					tabuleiro.cartasJogador2[getPosicaoVaziaNoCampo(jogador)] = jogador2.cartasMao[0];
          tabuleiro.cartasJogador2[0] -> atacarBool = false;
          if (tabuleiro.cartasJogador2[0] -> ataqueEspecial.compare("Iniciativa") == 0) {
            tabuleiro.cartasJogador2[0] -> atacarBool = true;
          }
					std::cout << "O Jogador 2 invocou o(a) " << jogador2.cartasMao[0] -> nome << '\n';
					jogador2.cartasMao[0] = &cartaNula;
				} else {
					std::cout << "Tabuleiro Cheio." << '\n';
				}
			}
			break;
		case 2: //Jogar a carta da segunda posicao
			if(jogador == (int) 1){
				if((jogador1.cartasMao[1] -> nome.compare(cartaNula.nome) != 0)){ //se a carta na posicao um nao � a carta nula
					tabuleiro.cartasJogador1[getPosicaoVaziaNoCampo(jogador)] = jogador1.cartasMao[1];
          tabuleiro.cartasJogador1[1] -> atacarBool = false;
          if (tabuleiro.cartasJogador1[1] -> ataqueEspecial.compare("Iniciativa") == 0) {
            tabuleiro.cartasJogador1[1] -> atacarBool = true;
          }
					std::cout << "O Jogador 1 invocou o(a) " << jogador1.cartasMao[1] -> nome << '\n';
					jogador1.cartasMao[1] = &cartaNula;

				} else {
					std::cout << "Tabuleiro Cheio." << '\n';
				}
			} else if(jogador == (int) 2){
				if((jogador2.cartasMao[1] -> nome.compare(cartaNula.nome) != 0)){ //se a carta na posicao um nao � a carta nula
					tabuleiro.cartasJogador2[getPosicaoVaziaNoCampo(jogador)] = jogador2.cartasMao[1];
          tabuleiro.cartasJogador2[1] -> atacarBool = false;
          if (tabuleiro.cartasJogador2[1] -> ataqueEspecial.compare("Iniciativa") == 0) {
            tabuleiro.cartasJogador2[1] -> atacarBool = true;
          }
					std::cout << "O Jogador 2 invocou o(a) " << jogador2.cartasMao[1] -> nome << '\n';
					jogador2.cartasMao[1] = &cartaNula;
				} else {
					std::cout << "Tabuleiro Cheio." << '\n';
				}
			}
			break;
		case 3: //Jogar a carta da terceira posicao
			if(jogador == (int) 1){
				if((jogador1.cartasMao[2] -> nome.compare(cartaNula.nome) != 0)){ //se a carta na posicao dois nao � a carta nula
					tabuleiro.cartasJogador1[getPosicaoVaziaNoCampo(jogador)] = jogador1.cartasMao[2];
          tabuleiro.cartasJogador1[2] -> atacarBool = false;
          if (tabuleiro.cartasJogador1[2] -> ataqueEspecial.compare("Iniciativa") == 0) {
            tabuleiro.cartasJogador1[2] -> atacarBool = true;
          }
					std::cout << "O Jogador 1 invocou o(a) " << jogador1.cartasMao[2] -> nome << '\n';
					jogador1.cartasMao[2] = &cartaNula;
				} else {
					std::cout << "Tabuleiro Cheio." << '\n';
				}
			} else if(jogador == (int) 2){
				if((jogador2.cartasMao[2] -> nome.compare(cartaNula.nome) != 0)){ //se a carta na posicao dois nao � a carta nula
					tabuleiro.cartasJogador2[getPosicaoVaziaNoCampo(jogador)] = jogador2.cartasMao[2];
          tabuleiro.cartasJogador2[2] -> atacarBool = false;
          if (tabuleiro.cartasJogador2[2] -> ataqueEspecial.compare("Iniciativa") == 0) {
            tabuleiro.cartasJogador2[2] -> atacarBool = true;
          }
					std::cout << "O Jogador 2 invocou o(a) " << jogador2.cartasMao[2] -> nome << '\n';
					jogador2.cartasMao[2] = &cartaNula;
				} else {
					std::cout << "Tabuleiro Cheio." << '\n';
				}
			}
			break;
		default:
			std::cout << "Comando Invalido." << '\n';
			break;
	}

	 if(jogador == 1){
  	telaJogador1("");
  }else{
  	telaJogador2("");
  }
}

// Verifica se o jogador tem menos de 3 cartas na mao.
bool jogadorTemMenosQue3CartasNaMao(int jogador){
	for(size_t i = 0; i < 3; i++){
		if(jogador == (int) 1){
			if(jogador1.cartasMao[i] -> nome.compare(cartaNula.nome) == 0){
				return true;
			}
		}else if(jogador == (int) 2){
			if(jogador2.cartasMao[i] -> nome.compare(cartaNula.nome) == 0){
				return true;
			}
		}

	}
	return false;
}

int getPosicaoVaziaNaMao(int jogador){
	if (jogador == (int) 1) { //retorna posicao vazia para o jogador 1
		for(size_t i = 0; i < 3; i++){
			if(jogador1.cartasMao[i] -> nome.compare(cartaNula.nome) == 0){
				return i;
			}
		}
	} else if (jogador == (int) 2) { //retorna posicao vazia para o jogador 2
		for(size_t i = 0; i < 3; i++){
			if(jogador2.cartasMao[i] -> nome.compare(cartaNula.nome) == 0){
				return i;
			}
		}
	}

	return 0;
}

// Adiciona uma carta aleatoria para a mao do jogador.
void puxarUmaCarta(int jogador, CartaStr cartas[]){
	int indiceAleatorio = rand() % 13;
	if(jogador == (int) 1){
		jogador1.cartasMao[getPosicaoVaziaNaMao(jogador)] = &cartas[indiceAleatorio];
		std::cout << "O Jogador 1 puxou o(a) " << cartas[indiceAleatorio].nome << '\n';

	} else if(jogador == (int) 2){
		jogador2.cartasMao[getPosicaoVaziaNaMao(jogador)] = &cartas[indiceAleatorio];
		std::cout << "O Jogador 2 puxou o(a) " << cartas[indiceAleatorio].nome << '\n';
	}

}

// Permite todas as cartas no tabuleiro atacarem.
void todasPodemAtacar(int jogador) {
  for (size_t i = 0; i < 3; i++) {
    if (jogador == 1 && tabuleiro.cartasJogador1[i] -> nome.compare(cartaNula.nome) != 0) {
      tabuleiro.cartasJogador1[i] -> atacarBool = true;
    }
    if (jogador == 2 && tabuleiro.cartasJogador2[i] -> nome.compare(cartaNula.nome) != 0) {
      tabuleiro.cartasJogador2[i] -> atacarBool = true;
    }
  }
}




// ####### JOGO #######
int main() {

  // Cartas:

  reiDaMontanha.nome = "Rei da Montanha";
  reiDaMontanha.vida = 3;
  reiDaMontanha.ataque = 2;
  reiDaMontanha.ataqueEspecial = "Iniciativa"; //pode atacar no mesmo turno que foi colocada.
  reiDaMontanha.atacarBool = false;

  loboCeleste.nome = "Lobo Celeste";
  loboCeleste.vida = 2;
  loboCeleste.ataque = 1;
  loboCeleste.ataqueEspecial = "Nenhum";
  loboCeleste.atacarBool = false;

  espectroNegro.nome = "Espectro Negro";
  espectroNegro.vida = 1;
  espectroNegro.ataque = 1;
  espectroNegro.ataqueEspecial = "Ataque Duplo"; //ataca duas vezes.
  espectroNegro.atacarBool = false;

  fortex.nome = "Fortex";
  fortex.vida = 5;
  fortex.ataque = 0;
  fortex.ataqueEspecial = "Provocar";
  fortex.atacarBool = false;

  ogroNegro.nome = "Ogro Negro";
  ogroNegro.vida = 2;
  ogroNegro.ataque = 1;
  ogroNegro.ataqueEspecial = "Ataque Duplo";
  ogroNegro.atacarBool = false;

  mercurioAlado.nome = "Mercurio Alado";
  mercurioAlado.vida = 2;
  mercurioAlado.ataque = 1;
  mercurioAlado.ataqueEspecial = "Iniciativa";
  mercurioAlado.atacarBool = false;

  cortanaAAntipatica.nome = "Cortana A Antipatica";
  cortanaAAntipatica.vida = 4;
  cortanaAAntipatica.ataque = 1;
  cortanaAAntipatica.ataqueEspecial = "Provocar"; //impede ataque direto ao jogador.
  cortanaAAntipatica.atacarBool = false;

  ciriAEngracada.nome = "Ciri A Engracada";
  ciriAEngracada.vida = 1;
  ciriAEngracada.ataque = 3;
  ciriAEngracada.ataqueEspecial = "Nenhum";
  ciriAEngracada.atacarBool = false;

  dellOFort.nome = "Dell O Fort";
  dellOFort.vida = 2;
  dellOFort.ataque = 2;
  dellOFort.ataqueEspecial = "Nenhum";
  dellOFort.atacarBool = false;

  HPn01.nome = "HP n01";
  HPn01.vida = 3;
  HPn01.ataque = 6;
  HPn01.ataqueEspecial = "Nenhum";
  HPn01.atacarBool = false;

  Javas.nome = "Javas";
  Javas.vida = 1;
  Javas.ataque = 1;
  Javas.ataqueEspecial = "Nenhum";
  Javas.atacarBool = false;

  CPlusivel.nome = "CPlusivel";
  CPlusivel.vida = 1;
  CPlusivel.ataque = 7;
  CPlusivel.ataqueEspecial = "Nenhum";
  CPlusivel.atacarBool = false;

  AntonelaASereia.nome = "Antonela A Sereia";
  AntonelaASereia.vida = 5;
  AntonelaASereia.ataque = 3;
  AntonelaASereia.ataqueEspecial = "Nenhum";
  AntonelaASereia.atacarBool = false;

  NokiaTijolao.nome = "NokiaTi jolao";
  NokiaTijolao.vida = 15;
  NokiaTijolao.ataque = 0;
  NokiaTijolao.ataqueEspecial = "Provocar";
  NokiaTijolao.atacarBool = false;

  ZeDaPeixeira.nome = "Ze Da Peixeira";
  ZeDaPeixeira.vida = 2;
  ZeDaPeixeira.ataque = 6;
  ZeDaPeixeira.ataqueEspecial = "Nenhum";
  ZeDaPeixeira.atacarBool = false;

  MosntroDonATAL.nome = "MosntroDonATAL";
  MosntroDonATAL.vida = 2;
  MosntroDonATAL.ataque = 2;
  MosntroDonATAL.ataqueEspecial = "Ataque Duplo";
  MosntroDonATAL.atacarBool = false;

  ogroAlbino.nome = "ogro Albino";
  ogroAlbino.vida = 2;
  ogroAlbino.ataque = 2;
  ogroAlbino.ataqueEspecial = "Ataque Duplo";
  ogroAlbino.atacarBool = false;

  deadLine.nome = "Dead a Line";
  deadLine.vida = 2;
  deadLine.ataque = 6;
  deadLine.ataqueEspecial = "Nenhum";
  deadLine.atacarBool = false;

  cartaNula.nome = "";
  cartaNula.ataqueEspecial = "";
  cartaNula.ataque = 0;
  cartaNula.vida = 0;
  cartaNula.atacarBool = true; // somente para a cartaNula essa campo é true;

  CartaStr cartas[18];

  cartas[0] = reiDaMontanha;
  cartas[1] = loboCeleste;
  cartas[2] = espectroNegro;
  cartas[3] = mercurioAlado;
  cartas[4] = ogroNegro;
  cartas[5] = fortex;
  cartas[6] = cortanaAAntipatica;
  cartas[7] = ciriAEngracada;
  cartas[8] = dellOFort;
  cartas[9] = HPn01;
  cartas[10] = Javas;
  cartas[11] = CPlusivel;
  cartas[12] = AntonelaASereia;
  cartas[13] = NokiaTijolao;
  cartas[14] = ZeDaPeixeira;
  cartas[15] = MosntroDonATAL;
  cartas[16] = ogroAlbino;
  cartas[17] = deadLine;


  srand ( time(NULL) ); //necessario para gerar numeros aleatorios em rand()

  for(size_t i = 0; i < 3; i++){

  	int indiceAleatorio = rand() % 18;
  	jogador1.cartasMao[i] = &cartas[indiceAleatorio];
  	indiceAleatorio = rand() % 18;
  	jogador2.cartasMao[i] = &cartas[indiceAleatorio];

  	tabuleiro.cartasJogador1[i] = &cartaNula;
  	tabuleiro.cartasJogador2[i] = &cartaNula;
  }
  // Jogadores:
  jogador1.nome = "Jogador 1";
  jogador1.vida = 10;
  jogador1.turno = true; // O jogador 1 sempre comeca o jogo.
  jogador1.jogarCartaBool = true;
  jogador2.nome = "Jogador 2";
  jogador2.vida = 10;
  jogador2.turno = false;
  jogador2.jogarCartaBool = true;

  //

  //Loops do jogo:
  bool fimDeJogo = false;
  while(!fimDeJogo) { // Mantem o jogo rodando.

    if (jogador1.vida <= 0 || jogador2.vida <= 0) {
      fimDeJogo = true;
    }

    if(jogadorTemMenosQue3CartasNaMao(1)){
    		puxarUmaCarta(1, cartas);
    }

    // imprime tela do jogador1
    telaJogador1("");
    while (jogador1.turno && jogador1.vida > 0) {
      string escolha;
      getline(cin, escolha);

      //fializar turno
      if (escolha == "FT" || escolha == "ft") {
        jogador1.jogarCartaBool = true;
        todasPodemAtacar(1);
        jogador1.turno = false;
        jogador2.turno = true;
      }

      if(escolha == "JC" || escolha == "jc") {
      	if((jogador1.jogarCartaBool) && !(campoDoJogadorEstaCheio(1))){
          jogarUmaCarta(1);
          jogador1.jogarCartaBool = false;
          telaJogador1("Jogada realizada com sucesso");
    		}else {
          telaJogador1("Voce nao pode jogar numa nova carta.");
        }
	    }
      if (escolha == "AJ" || escolha == "aj") {
        if (!campoDoJogadorEstaVazio(1)) {
          telaJogador1("Jogada realizada com sucesso");
          atacarJogadorInimigo(1);
        } else {
          telaJogador1("O tabuleiro esta vazio.");
        }
      }
      if (escolha == "AC" || escolha == "ac") {
        if (!(campoDoJogadorEstaVazio(1)) && !(campoDoJogadorEstaVazio(2))) {
          telaJogador1("Jogada realizada com sucesso");
          atacarCartaInimiga(1);
        } else {
          telaJogador1("Algum tabuleiro esta vazio.");
        }
      }


      if (jogador2.vida <= 0) {
        fimDeJogo = true;
      }
    }

    if(jogadorTemMenosQue3CartasNaMao(2)){
    		puxarUmaCarta(2, cartas);
    }

    telaJogador2("");
    while (jogador2.turno && jogador2.vida > 0) {
      string escolha;
      getline(cin, escolha);
      if (escolha == "FT" || escolha == "ft") {
        jogador2.jogarCartaBool = true;
        todasPodemAtacar(2);
        jogador1.turno = true;
        jogador2.turno = false;
      }
      if(escolha == "JC" || escolha == "jc") {
        if((jogador2.jogarCartaBool) && !(campoDoJogadorEstaCheio(2))){
          jogarUmaCarta(2);
          jogador2.jogarCartaBool = false;
          telaJogador2("Jogada realizada com sucesso");
        }else {
          telaJogador2("Voce nao pode jogar numa nova carta.");
        }
  	  }
      if (escolha == "AJ" || escolha == "aj") {
        if (!campoDoJogadorEstaVazio(2)) {
          telaJogador2("Jogada realizada com sucesso");
          atacarJogadorInimigo(2);
        } else {
          telaJogador2("O campo esta vazio.");
        }
      }
      if (escolha == "AC" || escolha == "ac") {
        if (!(campoDoJogadorEstaVazio(2)) && !(campoDoJogadorEstaVazio(1))) {
          telaJogador2("Jogada realizada com sucesso");
          atacarCartaInimiga(2);
        } else {
          telaJogador2("Algum tabuleiro esta vazio.");
        }
      }


      if (jogador1.vida <= 0) {
        fimDeJogo = true;
      }
    }
  }

  std::cout << "------------------------------------------------------------------------------------------------------" << '\n';
  std::cout << "Fim de jogo. ";
  if (jogador1.vida > 0) {
    std::cout << "O jogador 1 venceu!" << '\n';
  } else {
    std::cout << "O jogador 2 venceu!" << '\n';
  }
  std::cout << "------------------------------------------------------------------------------------------------------" << '\n';



  return 0;
}
