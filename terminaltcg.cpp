/* Terminal TCG;
  Adiel Andrade, Felipe Emerson, João Marcos e Raimundo Heitor;
  APLP 2018-1
*/

#include <iostream>
#include <string>
using namespace std;

// ####### ESTRUTURAS #######
struct CartaStr {
  string nome;
  short vida;
  short ataque;
  string ataqueEspecial;
}reiDaMontanha, loboCeleste, espectroNegro;

struct JogadorStr {
  string nome;
  short vida;
  CartaStr cartasMao[3];
  bool turno;
} jogador1, jogador2;

struct TabuleiroStr {
  CartaStr cartasJogador1[3];
  CartaStr cartasJogador2[3];
} tabuleiro;


// ####### FUNCOES #######
// Usa carta para atacar o jogador.
void atacarJogadorInimigo(struct CartaStr& carta, struct JogadorStr& jogador){
  jogador.vida -= carta.ataque;
  if (carta.ataqueEspecial == "Ataque Duplo") {
    jogador.vida -= carta.ataque;
  }
}

// Usa minhaCarta para atacar cartaInimiga.
void atacarCartaInimiga(struct CartaStr& minhaCarta, struct CartaStr& cartaInimiga){
  cartaInimiga.vida -= minhaCarta.ataque;
  if (minhaCarta.ataqueEspecial == "Ataque Duplo") {
    cartaInimiga.vida -= minhaCarta.ataque;
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

  // Jogadores:
  jogador1.nome = "Jogador 1";
  jogador1.vida = 10;
  jogador1.turno = true; // O jogador 1 sempre começa o jogo.
  jogador2.nome = "Jogador 2";
  jogador2.vida = 10;
  jogador2.turno = false;

  //Loops do jogo:
  bool fimDeJogo = false;
  while(!fimDeJogo) { // Mantem o jogo rodando.
    if (jogador1.vida <= 0 || jogador2.vida <= 0) {
      fimDeJogo = true;
    }
    // Tabuleiro para o jogador 1
    std::cout << "-----------------------------------------" << '\n';
    std::cout << "Vida Jogador 1= " << jogador1.vida << " | ";
    std::cout << "Vida Jogador 2= " << jogador2.vida << " |" << '\n';
    std::cout << "-------------------------------------------Tabuleiro: Jogador 1---------------------------------------" << '\n';
    for (size_t i = 0; i < 3; i++) {
      std::cout << "NOME: "<< tabuleiro.cartasJogador1[i].nome << " ";
      std::cout << "ATAQUE: " << tabuleiro.cartasJogador1[i].ataque << " ";
      std::cout << "VIDA: " << tabuleiro.cartasJogador1[i].vida << " ";
      std::cout << "PODER: " << tabuleiro.cartasJogador1[i].ataqueEspecial << '\n';
      std::cout << "" << '\n';
    }
    std::cout << "-------------------------------------------Tabuleiro: Jogador 2---------------------------------------" << '\n';
    for (size_t i = 0; i < 3; i++) {
      std::cout << "NOME: " << tabuleiro.cartasJogador2[i].nome << " ";
      std::cout << "ATAQUE: " << tabuleiro.cartasJogador2[i].ataque << " ";
      std::cout << "VIDA: " << tabuleiro.cartasJogador2[i].vida << " ";
      std::cout << "PODER: " << tabuleiro.cartasJogador2[i].ataqueEspecial << '\n';
      std::cout << "" << '\n';
    }
    while (jogador1.turno) {
      string escolha;
      std::cout << "Turno: Jogador 1" << '\n';
      getline(cin, escolha);
      if (escolha == "Finalizar Turno") {
        jogador1.turno = false;
        jogador2.turno = true;
      } else {
        std::cout << "Comando Invalido." << '\n';
      }

    }

    // Tabuleiro para o jogador 2
    std::cout << "-----------------------------------------" << '\n';
    std::cout << "Vida Jogador 1= " << jogador1.vida << " | ";
    std::cout << "Vida Jogador 2= " << jogador2.vida << " |" << '\n';
    std::cout << "-------------------------------------------Tabuleiro: Jogador 1---------------------------------------" << '\n';
    for (size_t i = 0; i < 3; i++) {
      std::cout << "NOME: "<< tabuleiro.cartasJogador1[i].nome << " ";
      std::cout << "ATAQUE: " << tabuleiro.cartasJogador1[i].ataque << " ";
      std::cout << "VIDA: " << tabuleiro.cartasJogador1[i].vida << " ";
      std::cout << "PODER: " << tabuleiro.cartasJogador1[i].ataqueEspecial << '\n';
      std::cout << "" << '\n';
    }
    std::cout << "-------------------------------------------Tabuleiro: Jogador 2---------------------------------------" << '\n';
    for (size_t i = 0; i < 3; i++) {
      std::cout << "NOME: " << tabuleiro.cartasJogador2[i].nome << " ";
      std::cout << "ATAQUE: " << tabuleiro.cartasJogador2[i].ataque << " ";
      std::cout << "VIDA: " << tabuleiro.cartasJogador2[i].vida << " ";
      std::cout << "PODER: " << tabuleiro.cartasJogador2[i].ataqueEspecial << '\n';
      std::cout << "" << '\n';
    }
    while (jogador2.turno) {
      string escolha;
      std::cout << "Turno: Jogador 2" << '\n';
      getline(cin, escolha);
      if (escolha == "Finalizar Turno") {
        jogador1.turno = true;
        jogador2.turno = false;
      } else {
        std::cout << "Comando Invalido." << '\n';
      }
    }

  }


  std::cout << "Fim de jogo. ";
  if (jogador1.vida > 0) {
    std::cout << "O jogador 1 venceu!" << '\n';
  } else {
    std::cout << "O jogador 2 venceu!" << '\n';
  }



  return 0;
}
