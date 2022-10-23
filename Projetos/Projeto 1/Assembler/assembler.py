assembly = 'ASM.txt' # Arquivo de entrada de contem o assembly
destinoBIN = 'BIN.txt' # Arquivo de saída que contem o binário formatado para VHDL

# definição dos mnemônicos e seus
# respectivo OPCODEs
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
}

# Converte o valor após o caractere arroba '@'
# em um valor hexadecimal de 2 dígitos (8 bits)
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
    line = "".join(line)
    return line

with open(assembly, "r", encoding='utf8') as f: #Abre o arquivo ASM
    lines = f.readlines() 
    
with open(destinoBIN, "w", encoding='utf8') as f:  #Abre o destino BIN
    cont = 0 
    label_dic = {}
    
    for line in lines:        
        #Verifica se a linha começa com alguns caracteres invalidos ('\n' ou ' ' ou '#')
        if (line.startswith('\n') or line.startswith(' ') or line.startswith('#')):
            line = line.replace("\n", "")
        
        else:            
            comentarioLine = defineComentario(line).replace("\n","") #Define o comentário da linha
            instrucaoLine = defineInstrucao(line).replace("\n","") #Define a instrução
            instrucaoLine = trataMnemonico(instrucaoLine) #Trata o mnemonico
                  
            if ':' in instrucaoLine:    
                label_dic[line.split(':')[0]] = cont
                del lines[cont]
     
            cont += 1 #Incrementa a variável de contagem, utilizada para incrementar as posições de memória no VHDL

    cont = 0 
    
    for line in lines:        
        
        #Verifica se a linha começa com alguns caracteres invalidos ('\n' ou ' ' ou '#')
        if (line.startswith('\n') or line.startswith(' ') or line.startswith('#')):
            line = line.replace("\n", "")
        else:
            comentarioLine = defineComentario(line).replace("\n","") 
            instrucaoLine = defineInstrucao(line).replace("\n","") 
            instrucaoLine = trataMnemonico(instrucaoLine) 
                              
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

            line = 'tmp(' + str(cont) + ') := ' + comando_hexa + '' + '  &  ' + str(Reg) +  '  &  ' +  '\''+ str(A8) + '\'' +   '  &  ' + 'x"' + numero_hexa + '"' + ';\t-- ' + comentarioLine + '\n'            
            cont += 1
            f.write(line) 