# imp-gen
 
O projeto imp-gen possui 3 linguagens:

1) A linguagem IMP que executa programas codificados na linguagem IMP;
2) A linguagem GEN (gerador) que gera entradas (um conjunto de numeros aleatórios) para uma instrução input em um programa;
3) A linguagem CONF (especificação) que define as especificações do numero de execuções de um programa, e o caminho dos programas que serão executados: o gabarito do professor e os exercícios dos alunos.

O diretório raiz possui os arquivos de funcionamento da linguagem IMP;
O diretório gerador possui os arquivos de funcionamento da linguagem GEN (gerador);
O diretório especificação possui os arquivos de funcionamento da linguagem CONF (especificação);
O diretório gabarito possui o programa de gabarito do professor (arquivo);
O diretório exercicio-alunos possui os programas de cada aluno (arquivos);
O diretório tests possui os programas de teste das linguagens.

Para executar um programa da linguagem CONF, deve-se inserir no topo do arquivo: #lang imp-gen/especificacao/conf
Para executar um programa da linguagem GEN, deve-se inserir no topo do arquivo: #lang imp-gen/gerador/gen
Para executar um programa da linguagem IMP, deve-se inserir no topo do arquivo: #lang imp-gen
