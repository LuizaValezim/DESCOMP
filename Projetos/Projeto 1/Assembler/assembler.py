"""
Criado em 07/Fevereiro/2022

@autor: Marco Mello e Paulo Santos


Regras:

1) O Arquivo ASM.txt não pode conter linhas iniciadas com caracter ' ' ou '\n')
2) Linhas somente com comentários são excluídas 
3) Instruções sem comentário no arquivo ASM receberão como comentário no arquivo BIN a própria instrução
4) Exemplo de codigo invalido:
                            0.___JSR @14 #comentario1
                            1.___#comentario2           << Invalido ( Linha somente com comentário )
                            2.___                       << Invalido ( Linha vazia )
                            3.___JMP @5  #comentario3
                            4.___JEQ @9
                            5.___NOP
                            6.___NOP
                            7.___                       << Invalido ( Linha vazia )
                            8.___LDI $5                 << Invalido ( Linha iniciada com espaço (' ') )
                            9.___ STA $0
                            10.__CEQ @0
                            11.__JMP @2  #comentario4
                            12.__NOP
                            13.__ LDI $4                << Invalido ( Linha iniciada com espaço (' ') )
                            14.__CEQ @0
                            15.__JEQ @3
                            16.__#comentario5           << Invalido ( Linha somente com comentário )
                            17.__JMP @13
                            18.__NOP
                            19.__RET
                                
5) Exemplo de código válido (Arquivo ASM.txt):
                            0.___JSR @14 #comentario1
                            1.___JMP @5  #comentario3
                            2.___JEQ @9
                            3.___NOP
                            4.___NOP
                            5.___LDI $5
                            6.___STA $0
                            7.___CEQ @0
                            8.___JMP @2  #comentario4
                            9.___NOP
                            10.__LDI $4
                            11.__CEQ @0
                            12.__JEQ @3
                            13.__JMP @13
                            14.__NOP
                            15.__RET
                            
6) Resultado do código válido (Arquivo BIN.txt):
                            0.__tmp(0) := x"90E"; -- comentario1
                            1.__tmp(1) := x"605"; -- comentario3
                            2.__tmp(2) := x"709"; -- JEQ @9
                            3.__tmp(3) := x"000"; -- NOP
                            4.__tmp(4) := x"000"; -- NOP
                            5.__tmp(5) := x"405"; -- LDI $5
                            6.__tmp(6) := x"500"; -- STA $0
                            7.__tmp(7) := x"800"; -- CEQ @0
                            8.__tmp(8) := x"602"; -- comentario4
                            9.__tmp(9) := x"000"; -- NOP
                            10._tmp(10) := x"404"; -- LDI $4
                            11._tmp(11) := x"800"; -- CEQ @0
                            12._tmp(12) := x"703"; -- JEQ @3
                            13._tmp(13) := x"60D"; -- JMP @13
                            14._tmp(14) := x"000"; -- NOP
                            15._tmp(15) := x"A00"; -- RET

"""

import re

assembly = 'ASM.txt' #Arquivo de entrada de contem o assembly
destinoBIN = 'BIN.txt' #Arquivo de saída que contem o binário formatado para VHDL

#definição dos mnemônicos e seus
#respectivo OPCODEs (em Hexadecimal)
mne =	{ 
       "0":   "NOP",
       "1":   "LDA",
       "2":  "SOMA",
       "3":   "SUB",
       "4":   "LDI",
       "5":   "STA",
       "6":   "JMP",
       "7":   "JEQ",
       "8":   "CEQ",
       "9":   "JSR",
       "A":   "RET",
       "B":  "ANDI",
       "C":  "CLT",
       "D":  "JLT",
       "E":  "ADDI",
       "F":  "SUBI"
}


def  converteArroba(line, label_dict):
    Reg = "R0"
    if ',' in line:
        line = line.split(',')
        Reg = line[1]
        line = line[0].split('@')
    else:
        line = line.split('@')

    comando_hexa = line[0]

    if line[1] in label_dict:
        numero = label_dict[line[1]]
    else:
        numero = int(line[1])

    numero_bin = bin(numero)[2:].zfill(9)

    numero_bin_8 = numero_bin[1:]
    A8 = numero_bin[:1]

    numero_hexa = hex(int(numero_bin_8, 2))[2:].zfill(2)

    # print(comando_hexa, numero_hexa, A8, Reg)

    return comando_hexa, numero_hexa, A8, Reg

#Converte o valor após o caractere cifrão'$'
#em um valor hexadecimal de 2 dígitos (8 bits) 
def  converteCifrao(line):
    Reg = "R0"
    if ',' in line:
        line = line.split(',')
        Reg = line[1]
        line = line[0].split('$')
    else:
        line = line.split('$')

    comando_hexa = line[0]

    numero = int(line[1])
    numero_bin = bin(numero)[2:].zfill(9)

    numero_bin_8 = numero_bin[1:]
    A8 = numero_bin[:1]


    numero_hexa = hex(int(numero_bin_8, 2))[2:].zfill(2)

    # print(comando_hexa, numero_hexa, A8, Reg)

    return comando_hexa, numero_hexa, A8, Reg

        
#Define a string que representa o comentário
#a partir do caractere cerquilha '#'
def defineComentario(line):
    if '#' in line:
        line = line.split('#')
        line = line[0] + "\t#" + line[1]
        return line
    else:
        return line

#Remove o comentário a partir do caractere cerquilha '#',
#deixando apenas a instrução
def defineInstrucao(line):
    line = line.split('#')
    line = line[0]
    return line
    
#Consulta o dicionário e "converte" o mnemônico em
#seu respectivo valor em hexadecimal
def trataMnemonico(line):
    line = line.replace("\n", "") #Remove o caracter de final de linha
    line = line.replace("\t", "") #Remove o caracter de tabulacao
    line = line.split(' ')
    # if line[0] in mne:
    #     line[0] = mne[line[0]]
    line = "".join(line)
    #print(line)
    return line

with open(assembly, "r", encoding='utf8') as f: #Abre o arquivo ASM
    lines = f.readlines() #Verifica a quantidade de linhas
    
    
with open(destinoBIN, "w", encoding='utf8') as f:  #Abre o destino BIN

    cont = 0 #Cria uma variável para contagem
    label_dic = {}
    
    for line in lines:        
        
        #Verifica se a linha começa com alguns caracteres invalidos ('\n' ou ' ' ou '#')
        if (line.startswith('\n') or line.startswith(' ') or line.startswith('#')):
            line = line.replace("\n", "")
            print("-- Sintaxe invalida" + ' na Linha: ' + ' --> (' + line + ')') #Print apenas para debug
        
        #Se a linha for válida para conversão, executa
        else:
            #label_linhas[]
            
            #Exemplo de linha => 1. JSR @14 #comentario1
            comentarioLine = defineComentario(line).replace("\n","") #Define o comentário da linha. Ex: #comentario1
            instrucaoLine = defineInstrucao(line).replace("\n","") #Define a instrução. Ex: JSR @14
            
            instrucaoLine = trataMnemonico(instrucaoLine) #Trata o mnemonico. Ex(JSR @14): x"9" @14
                  
            if ':' in instrucaoLine:
                #print(line.split(':')[0])
                label_dic[line.split(':')[0]] = cont
                del lines[cont]
                
 
                            
            cont+=1 #Incrementa a variável de contagem, utilizada para incrementar as posições de memória no VHDL

    #print(label_dic)
    #print(lines[13])

    cont = 0 #Cria uma variável para contagem
    
    for line in lines:        
        
        #Verifica se a linha começa com alguns caracteres invalidos ('\n' ou ' ' ou '#')
        if (line.startswith('\n') or line.startswith(' ') or line.startswith('#')):
            line = line.replace("\n", "")
            print("-- Sintaxe invalida" + ' na Linha: ' + ' --> (' + line + ')') #Print apenas para debug
        
        #Se a linha for válida para conversão, executa
        else:
            
            #Exemplo de linha => 1. JSR @14 #comentario1
            comentarioLine = defineComentario(line).replace("\n","") #Define o comentário da linha. Ex: #comentario1
            instrucaoLine = defineInstrucao(line).replace("\n","") #Define a instrução. Ex: JSR @14
            
            instrucaoLine = trataMnemonico(instrucaoLine) #Trata o mnemonico. Ex(JSR @14): x"9" @14

            #print("AQUII : ", instrucaoLine)
                              
            if '@' in instrucaoLine: #Se encontrar o caractere arroba '@' 
                comando_hexa, numero_hexa, A8, Reg = converteArroba(instrucaoLine, label_dic) #converte o número após o caractere Ex(JSR @14): x"9" x"0E"
                    
            elif '$' in instrucaoLine: #Se encontrar o caractere cifrao '$' 
                comando_hexa, numero_hexa, A8, Reg = converteCifrao(instrucaoLine) #converte o número após o caractere Ex(LDI $5): x"4" x"05"


            else: #Senão, se a instrução nao possuir nenhum imediator, ou seja, nao conter '@' ou '$'
                instrucaoLine = instrucaoLine.replace("\n", "") #Remove a quebra de linha
                comando_hexa = instrucaoLine
                A8 = '0'
                Reg = "R0"
                numero_hexa = '00'

            
            #line = 'tmp(' + str(cont) + ') := x"' + comando_hexa + '";\t-- ' + comentarioLine + '\n'  #Formata para o arquivo BIN
                                                                                                       #Entrada => 1. JSR @14 #comentario1
                                                                                                       #Saída =>   1. tmp(0) := x"90E";	-- JSR @14 	#comentario1
            line = 'tmp(' + str(cont) + ') := ' + comando_hexa + '' + '  &  ' + str(Reg) +  '  &  ' +  '\''+ str(A8) + '\'' +   '  &  ' + 'x"' + numero_hexa + '"' + ';\t-- ' + comentarioLine + '\n'  
                            
            cont+=1 #Incrementa a variável de contagem, utilizada para incrementar as posições de memória no VHDL
            f.write(line) #Escreve no arquivo BIN.txt
            
            print(line,end = '') #Print apenas para debug