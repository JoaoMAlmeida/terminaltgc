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
  unsigned short vida;
  unsigned short ataque;
  string ataqueEspecial;
}reiDaMontanha, loboCeleste, espectroNegro;

struct JogadorStr {
  string nome;
  unsigned short vida;
  CartaStr cartasMao[3];
} jogador1, jogador2;

struct TabuleiroStr {
  CartaStr cartasJogador1[3];
  CartaStr cartasJogador2[3];
} tabuleiro;


// ####### FUNCOES #######
void atacarJogadorInimigo(struct CartaStr& carta, struct JogadorStr& jogador){
  jogador.vida -= carta.ataque;
  if (carta.ataqueEspecial == "Ataque Duplo") {
    jogador.vida -= carta.ataque;
  }
}

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
  espectroNegro.ataqueEspecial = "Ataque Duplo"; //ataca duas vezes

  // Jogadores:
  jogador1.nome = "Jogador 1";
  jogador1.vida = 10;
  jogador2.nome = "Jogador 2";
  jogador2.vida = 10;


  return 0;
}
