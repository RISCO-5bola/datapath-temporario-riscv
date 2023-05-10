### Documentação do repositório temporário

 Esta é a implementação em Verilog do datapath da aula 12 do Grupo 3 de Sistemas digitais II.

## Contextualização
 Na disciplina de SDII, o nosso grupo (03) aceitou o desafio de fazer entregas paralelas em relação aos demais grupos da sala. Nas nossas entregas, iremos avançar na codificação do RISC-V de 64 bits em verilog com as extensões de ponto flutuante e implementação em FPGA.

 Essa entrega específica contém o circuito capaz de implementar a soma, a subtração, tanto com valores nos registradores, quanto com immediates (constantes) fornecidas. Além disso, as instruções de mundança de fluxo das instruções (BRANCH) foram implementadas. A seguir, mostramos melhor quais instruções especificas já estão funcionais no circuito. 

 ---> Essas implementações estão se
 
## Compilação

## Instruções implementadas
As seguintes instruções foram implementadas:
- add: 
- sub: subtração co
- addi: add immediate
- subbi: essa instrução é apenas um add com immediate negativo
- BEQ: branch if equal
- BNE: branch if not equal
- BLT: branch if less than
- BGE: branch if greater than or equal to
- BLTU: branch if less than (unsigned)
- BGEU: branch if greater than or equal to(unsigned)

## Datapath
Abaixo está o datapath dessa entrega:
![datapath](https://raw.githubusercontent.com/RISCO-5bola/datapath-temporario-riscv/main/index.png?token=GHSAT0AAAAAACAU3YLCXNCQSDEALBY7I6HEZC3ZOPQ)

Atenção: o papel da Unidade de controle é feito pela testbench.

## Ondas analizadas
 Nos comentários do arquivo index_tb.v, são mostradas os valores esperados para os registradores após cada uma das instruções. Sendo assim, a descrição da testagem das instruções implementadas está presente no arquivo citado (index_tb.v)

 As instruções em binário estão no arquivo ./Memory/InstructionMemory.v e seguem o Instruction Set oficial do RISC-V.
 
 Atenção: cada um dos módulos foi testado individualmente e verificado no GTKWave para que tivesse o comportamento esperando. Portanto, os outros testes estão presentes nos arquivos *_tb.v presentes espalhados nas respectivas pastas, sempre próximos do módulo testado.
 
 Abaixo, uma imagem da análise de sinais:
 ![wave]()