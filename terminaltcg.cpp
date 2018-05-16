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
}reiDaMontanha, loboCeleste, espectroNegro, cartaNula;

struct JogadorStr {
  string nome;
  short vida;
  CartaStr *cartasMao[3];
  bool turno;
} jogador1, jogador2;

struct TabuleiroStr {
  CartaStr *cartasJogador1[3];
  CartaStr *cartasJogador2[3];
} tabuleiro;

// ####### FUNCOES #######
// Usa carta para atacar o jogador adversario.
void atacarJogadorInimigo(struct TabuleiroStr& tabuleiro, int jogador){
  int cartaOpt;
  std::cout << "Escolha uma carta sua para atacar (1, 2 ou 3)" << '\n';
  cin >> cartaOpt;

  if (jogador == 1 && tabuleiro.cartasJogador1[cartaOpt-1] -> nome.compare(cartaNula.nome) != 0) {
    jogador2.vida -= tabuleiro.cartasJogador1[cartaOpt-1] -> ataque;
    std::cout << "A carta " << tabuleiro.cartasJogador1[cartaOpt-1] -> nome << " atacou o jogador 2" << '\n';
  } else if (jogador == 2 && tabuleiro.cartasJogador2[cartaOpt-1] -> nome.compare(cartaNula.nome) != 0) {
    jogador1.vida -= tabuleiro.cartasJogador2[cartaOpt-1] -> ataque;
    std::cout << "A carta " << tabuleiro.cartasJogador2[cartaOpt-1] -> nome << " atacou o jogador 1" << '\n';
  } else {
    std::cout << "Carta nao existe." << '\n';
  }
}

// Usa uma carta do jogador para atacar uma carta adversaria.
void atacarCartaInimiga(struct TabuleiroStr& tabuleiro, int jogador){
  int cartaOpt;
  int cartaIni;
  std::cout << "Escolha uma carta sua para atacar (1, 2 ou 3)" << '\n';
  cin >> cartaOpt;
  std::cout << "Escolha uma carta inimiga para atacar (1, 2 ou 3)" << '\n';
  cin >> cartaIni;

  if (jogador == 1 && tabuleiro.cartasJogador1[cartaOpt-1] -> nome.compare(cartaNula.nome) != 0 && tabuleiro.cartasJogador2[cartaIni-1] -> nome.compare(cartaNula.nome) != 0) {
    tabuleiro.cartasJogador2[cartaIni-1] -> vida -= tabuleiro.cartasJogador1[cartaOpt-1] -> ataque;
    std::cout << "A carta " << tabuleiro.cartasJogador1[cartaOpt-1] -> nome << " atacou a carta " << tabuleiro.cartasJogador2[cartaIni-1] -> nome << '\n';
    if (tabuleiro.cartasJogador2[cartaIni-1] -> vida <= 0) {
      tabuleiro.cartasJogador2[cartaIni-1] = &cartaNula;
    }
  } else if (jogador == 2 && tabuleiro.cartasJogador2[cartaOpt-1] -> nome.compare(cartaNula.nome) != 0 && tabuleiro.cartasJogador1[cartaIni-1] -> nome.compare(cartaNula.nome) != 0) {
    tabuleiro.cartasJogador1[cartaIni-1] -> vida -= tabuleiro.cartasJogador2[cartaOpt-1] -> ataque;
    std::cout << "A carta " << tabuleiro.cartasJogador2[cartaOpt-1] -> nome << " atacou a carta " << tabuleiro.cartasJogador1[cartaIni-1] -> nome << '\n';
    if (tabuleiro.cartasJogador1[cartaIni-1] -> vida <= 0) {
      tabuleiro.cartasJogador1[cartaIni-1] = &cartaNula;
    }
  } else {
    std::cout << "Carta nao existe." << '\n';
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
					jogador1.cartasMao[0] = &cartaNula;
				} else {
					std::cout << "Campo Cheio." << '\n';
				}
			} else if(jogador == (int) 2){
				if((jogador2.cartasMao[0] -> nome.compare(cartaNula.nome) != 0)){ //se a carta na posicao zero nao � a carta nula
					tabuleiro.cartasJogador2[getPosicaoVaziaNoCampo(jogador)] = jogador2.cartasMao[0];
					jogador2.cartasMao[0] = &cartaNula;
				} else {
					std::cout << "Campo Cheio." << '\n';
				}
			}
			break;
		case 2: //Jogar a carta da segunda posicao
			if(jogador == (int) 1){
				if((jogador1.cartasMao[1] -> nome.compare(cartaNula.nome) != 0)){ //se a carta na posicao um nao � a carta nula
					tabuleiro.cartasJogador1[getPosicaoVaziaNoCampo(jogador)] = jogador1.cartasMao[1];
					jogador1.cartasMao[1] = &cartaNula;
				} else {
					std::cout << "Campo Cheio." << '\n';
				}
			} else if(jogador == (int) 2){
				if((jogador2.cartasMao[1] -> nome.compare(cartaNula.nome) != 0)){ //se a carta na posicao um nao � a carta nula
					tabuleiro.cartasJogador2[getPosicaoVaziaNoCampo(jogador)] = jogador2.cartasMao[1];
					jogador2.cartasMao[1] = &cartaNula;
				} else {
					std::cout << "Campo Cheio." << '\n';
				}
			}
			break;
		case 3: //Jogar a carta da terceira posicao
			if(jogador == (int) 1){
				if((jogador1.cartasMao[2] -> nome.compare(cartaNula.nome) != 0)){ //se a carta na posicao dois nao � a carta nula
					tabuleiro.cartasJogador1[getPosicaoVaziaNoCampo(jogador)] = jogador1.cartasMao[2];
					jogador1.cartasMao[2] = &cartaNula;
				} else {
					std::cout << "Campo Cheio." << '\n';
				}
			} else if(jogador == (int) 2){
				if((jogador2.cartasMao[2] -> nome.compare(cartaNula.nome) != 0)){ //se a carta na posicao dois nao � a carta nula
					tabuleiro.cartasJogador2[getPosicaoVaziaNoCampo(jogador)] = jogador2.cartasMao[2];
					jogador2.cartasMao[2] = &cartaNula;
				} else {
					std::cout << "Campo Cheio." << '\n';
				}
			}
			break;
		default:
			std::cout << "Comando Invalido." << '\n';
			break;
	}
}

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

void puxarUmaCarta(int jogador, CartaStr cartas[]){
	int indiceAleatorio = rand() % 3;
	if(jogador == (int) 1){
		jogador1.cartasMao[getPosicaoVaziaNaMao(jogador)] = &cartas[indiceAleatorio];

	} else if(jogador == (int) 2){
		jogador2.cartasMao[getPosicaoVaziaNaMao(jogador)] = &cartas[indiceAleatorio];
	}
}




// ####### JOGO #######
int main() {

  // Cartas:
  reiDaMontanha.nome = "Rei da Montanha";
  reiDaMontanha.vida = 3;
  reiDaMontanha.ataque = 2;
  reiDaMontanha.ataqueEspecial = "Nenhum";
  loboCeleste.nome = "Lobo Celeste";
  loboCeleste.vida = 2;
  loboCeleste.ataque = 1;
  loboCeleste.ataqueEspecial = "Provocar"; //impede ataque direto ao jogador.
  espectroNegro.nome = "Espectro Negro";
  espectroNegro.vida = 1;
  espectroNegro.ataque = 1;
  espectroNegro.ataqueEspecial = "Ataque Duplo"; //ataca duas vezes.
  cartaNula.nome = "";
  cartaNula.ataqueEspecial = "";
  cartaNula.ataque = 0;
  cartaNula.vida = 0;

  CartaStr cartas[3];

  cartas[0] = reiDaMontanha;
  cartas[1] = loboCeleste;
  cartas[2] = espectroNegro;

  srand ( time(NULL) ); //necessario para gerar numeros aleatorios em rand()

  for(size_t i = 0; i < 3; i++){

  	int indiceAleatorio = rand() % 3;
  	jogador1.cartasMao[i] = &cartas[indiceAleatorio];
  	indiceAleatorio = rand() % 3;
  	jogador2.cartasMao[i] = &cartas[indiceAleatorio];

  	tabuleiro.cartasJogador1[i] = &cartaNula;
  	tabuleiro.cartasJogador2[i] = &cartaNula;
  }

  // Jogadores:
  jogador1.nome = "Jogador 1";
  jogador1.vida = 10;
  jogador1.turno = true; // O jogador 1 sempre come�a o jogo.
  jogador2.nome = "Jogador 2";
  jogador2.vida = 10;
  jogador2.turno = false;

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

    // Tabuleiro para o jogador 1
    std::cout << "-----------------------------------------" << '\n';
    std::cout << "Vida Jogador 1= " << jogador1.vida << " | ";
    std::cout << "Vida Jogador 2= " << jogador2.vida << " |" << '\n';
    std::cout << "---------------Mao: Jogador 1---------------" << '\n';
    for(size_t i = 0; i < 3; i++){
        std::cout << "Carta " << i+1 << ": " << "NOME: "<< jogador1.cartasMao[i] -> nome << " ";
        std::cout << "" << '\n';
    }
    std::cout << "-------------------------------------------Tabuleiro: Jogador 1---------------------------------------" << '\n';
    for (size_t i = 0; i < 3; i++) {
      std::cout << "NOME: "<< tabuleiro.cartasJogador1[i] -> nome << " ";
      std::cout << "ATAQUE: " << tabuleiro.cartasJogador1[i] -> ataque << " ";
      std::cout << "VIDA: " << tabuleiro.cartasJogador1[i] -> vida << " ";
      std::cout << "PODER: " << tabuleiro.cartasJogador1[i] -> ataqueEspecial << '\n';
      std::cout << "" << '\n';
    }
    std::cout << "-------------------------------------------Tabuleiro: Jogador 2---------------------------------------" << '\n';
    for (size_t i = 0; i < 3; i++) {
      std::cout << "NOME: " << tabuleiro.cartasJogador2[i] -> nome << " ";
      std::cout << "ATAQUE: " << tabuleiro.cartasJogador2[i] -> ataque << " ";
      std::cout << "VIDA: " << tabuleiro.cartasJogador2[i] -> vida << " ";
      std::cout << "PODER: " << tabuleiro.cartasJogador2[i] -> ataqueEspecial << '\n';
      std::cout << "" << '\n';
    }
    while (jogador1.turno && jogador1.vida > 0) {
      string escolha;
      std::cout << "Turno: Jogador 1" << '\n';
      getline(cin, escolha);
      if (escolha == "Finalizar turno") {
        jogador1.turno = false;
        jogador2.turno = true;
      }
      if(escolha == "Jogar uma carta") {
      	if(!campoDoJogadorEstaCheio(1)){
      		jogarUmaCarta(1);
      		jogador1.turno = false;
      		jogador2.turno = true;
    		} else {
    			std::cout << "Tabuleiro Cheio." << '\n';
    		}
	    }
      if (escolha == "Atacar jogador") {
        if (!campoDoJogadorEstaVazio(1)) {
          atacarJogadorInimigo(tabuleiro, 1);
        } else {
          std::cout << "O tabuleiro esta vazio." << '\n';
        }
      }
      if (escolha == "Atacar carta") {
        if (!(campoDoJogadorEstaVazio(1)) && !(campoDoJogadorEstaVazio(2))) {
          atacarCartaInimiga(tabuleiro, 1);
        } else {
          std::cout << "Algum tabuleiro esta vazio." << '\n';
        }
      }


      if (jogador2.vida <= 0) {
        fimDeJogo = true;
      }
    }

    if(jogadorTemMenosQue3CartasNaMao(2)){
    		puxarUmaCarta(2, cartas);
    	}

    // Tabuleiro para o jogador 2
    std::cout << "-----------------------------------------" << '\n';
    std::cout << "Vida Jogador 1= " << jogador1.vida << " | ";
    std::cout << "Vida Jogador 2= " << jogador2.vida << " |" << '\n';
    std::cout << "--------------------------------------------Mao: Jogador 2--------------------------------------------" << '\n';
    for(size_t i = 0; i < 3; i++){
        std::cout << "Carta " << i+1 << ": " << "NOME: "<< jogador2.cartasMao[i] -> nome << " ";
        std::cout << "" << '\n';
    }
    std::cout << "-------------------------------------------Tabuleiro: Jogador 1---------------------------------------" << '\n';
    for (size_t i = 0; i < 3; i++) {
      std::cout << "NOME: "<< tabuleiro.cartasJogador1[i] -> nome << " ";
      std::cout << "ATAQUE: " << tabuleiro.cartasJogador1[i] -> ataque << " ";
      std::cout << "VIDA: " << tabuleiro.cartasJogador1[i] -> vida << " ";
      std::cout << "PODER: " << tabuleiro.cartasJogador1[i] -> ataqueEspecial << '\n';
      std::cout << "" << '\n';
    }
    std::cout << "-------------------------------------------Tabuleiro: Jogador 2---------------------------------------" << '\n';
    for (size_t i = 0; i < 3; i++) {
      std::cout << "NOME: " << tabuleiro.cartasJogador2[i] -> nome << " ";
      std::cout << "ATAQUE: " << tabuleiro.cartasJogador2[i] -> ataque << " ";
      std::cout << "VIDA: " << tabuleiro.cartasJogador2[i] -> vida << " ";
      std::cout << "PODER: " << tabuleiro.cartasJogador2[i] -> ataqueEspecial << '\n';
      std::cout << "" << '\n';
    }

    while (jogador2.turno && jogador2.vida > 0) {
      string escolha;
      std::cout << "Turno: Jogador 2" << '\n';
      getline(cin, escolha);
      if (escolha == "Finalizar turno") {
        jogador1.turno = true;
        jogador2.turno = false;
      }
      if(escolha == "Jogar uma carta") {
      	if(!campoDoJogadorEstaCheio(2)){
      		jogarUmaCarta(2);
      		jogador2.turno = false;
      		jogador1.turno = true;
  		} else {
  			std::cout << "Tabuleiro Cheio." << '\n';
  		  }
  	  }
      if (escolha == "Atacar jogador") {
        if (!campoDoJogadorEstaVazio(2)) {
          atacarJogadorInimigo(tabuleiro, 2);
        } else {
          std::cout << "O campo esta vazio." << '\n';
        }
      }
      if (escolha == "Atacar carta") {
        if (!(campoDoJogadorEstaVazio(2)) && !(campoDoJogadorEstaVazio(1))) {
          atacarCartaInimiga(tabuleiro, 2);
        } else {
          std::cout << "Algum tabuleiro esta vazio." << '\n';
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
