
#### Resources


Guia de utilização do módulo _Resources_ presentes no projeto.

Esta é uma tentativa de mostrar como utilizar os principais resources presentes no projeto base, e que pode ser re-utilizado como guideline de novos projetos.

Se você tiver sugestões, ou desejar adicionar novas funcionalidades, elas são sempre bem-vindas. Assim podemos sempre evoluir nos nossos processos resultando e mais qualidade nas nossas entregas.

----

#### String.swift

* A extensão _String_ possui funções que visam facilitar a formatação e validação de tipos Strings. 
Abaixo, algumas funções e suas utilizações.

----

`onlyNumbers()` -  Retorna apenas os números presentes na string.

Exemplo de uso:

`'Abcd1234ef56'.onlyNumbers()` ->  retorna '123456'  

 ----

 `isCPF()` -  Retorna  se a string  contem um cpf válido.

 Exemplo de uso:

 `'68815717048'.isCPF()` ->  retorna _true_  
 
 ----
 
 `isCNPJ()` -  Retorna  se a string  contem um cnpj válido.

 Exemplo de uso:

 `'68815717048'.isCNPJ()` ->  retorna _false_  
 
 ----
 
 `isEmail()` -  Retorna  se a string  contem um email válido.

 Exemplo de uso:

`'teste@teste.com'.isEmail()` ->  retorna _true_  
 
 ----
  
  `formatCurrency(value: Double)` ->  Retorna  o valor double passado como parâmetro formatado para moeda. 

  Exemplo de uso:

`"".foformatCurrency(value: 3.5)` ->  retorna "R$ 3,50" 
  
  ----

  `toBase64()` -  Retorna  a string utf8 atual  em base 64.

  Exemplo de uso:

 `'teste'.toBase64()` ->  retorna  o valor em base64
  
  ----


`fromBase64()` -  Retorna  uma string  em base 64 formatada para utf8.

Exemplo de uso:

`'String em base 64'.fromBase64()` ->  retorna  o valor em utf8
    
----
 
 `toDate(formato: String)` -  Retorna  objeto Date, baseado na String e no formato passado 

  Exemplo de uso:

 `'2020-01-29'.toDate('yyyy-MM-dd')` ->  retorna  o objeto Date com a data '29/01/2020'
  
  ----
  

  #### UIColor.swift


* A extensão _UIColor_ possui as cores usadas no projeto.  Originalmente as cores são definidas no arquivo `Resources/Colors.xcassets`.  A extensão então deve fazer referência a essas cores, e caso for adiciona alguma, é necessário replicar a função e propriedade na extensão, para fácil acesso. 

Exemplo de uso:

`label.textColor = UIColor.activeTextColor`
    
----

  #### UIFont.swift


* A extensão _UIFont_ possui as fonts usadas no projeto.  Originalmente as fonts são adicionadas na pasta  `fonts/`, e devem ser incluidas no arquivo `info.plist`, no elemento: `Fonts provided by application`. A extensão então deve fazer referência a essas fonts, e caso for adiciona alguma, é necessário replicar a função e propriedade na extensão, para fácil acesso. 

Exemplo de usos:

`label.font = UIFont.opensansBold`

`label.font = UIFont.bold()`
    
`label.font = UIFont.italic()`
    
----



  #### Dictionay.swift


* A extensão _Dictionay_ possui funções que visam facilitar o trabalho com listagens. 
Abaixo, um exemplo de utilização.

Exemplo de uso:


```
var headers = [String: String]()
headers["key1"] = "value1"
headers["key2"] = "value2"

let body = headers.encodeAsURLParams()
```
Retorno -> 'key2=value2&key1=value1'
    
----

  #### UIImage.swift


* A extensão _UIImage_ possui as funções  e extensões usadas no projeto para trabalhar com imagens.  

Exemplo de usos:

`myImage.withBluer()` -> adiciona o efeito Blur na imagem. 

`let myImage = UIImage(color: myUIColor, size: CGSize(width: 100, height: 100))` -> Cria uma imagem de 100 x 100 com a cor que eu definir.
    
`UIImage.with("Titulo", color: myUIColor)` -> Add um texto e uma cor de background na imagem
    
`UIImage.tint(color: myUIColor)` -> pinta uma cor  na imagem

`myImage.image(alpha: 20.0)` -> adiciona transparência na imagem. 

`myImage.blackened(image)` -> escurece a imagem. 

`myImage.colorized(color: myUIColor)` -> adiciona uma mascara de cor sobre a imagem

`myImage.monochrome(color: myUIColor, intensity: 10.0)` -> adiciona uma mascara monocromática sobre a imagem

`myImage.resize(requestSize: myCGSize)` -> redimenciona a imagem
    
----


#### UIAlertController.swift


* A extensão _UIAlertController_ possui as funções  e extensões usadas no projeto para  exibir alertas e diálogos ao usuário.
    Todas as funções tem funcionalidades parecidas, alterando apenas os parâmetros de entrada, que podem ser o _ViewController_, _titulo_, _message_, _ações_, etc 


----


#### UIView.swift


* A extensão _UIView_ possui as funções, propriedades  e extensões usadas no projeto para trabalhar com as View.

Exemplo de usos:


`myView.cornerRadius = myCGFloat` -> arredonda a view 

`myView.borderColor = myUIColor` -> cor da borda

`myView.borderWidth = myCGFloat` -> espessura da borda

`myView.shadowColor = myUIColor` -> cor da sombra

`myView.addDashedBorder()` -> Add borda pontilhada

`myView.getSnapshotImage()` -> retorna uma UIImage com o printScreen da tela

`myView.roundCorners(corners: myUIRectCorner, radius: myCGFloat)` -> arredonda a view de acordo com o valor passado

`myView.simpleBorder(width: 1.0, color: myUIColor)` -> configura uma borda na espessura e cor passadas.

`myView.circle()` -> Transforma a view num circulo
 
 `myView.applyGradient(on bounds: myCGRect, cornerRadius: myCGFloat, initialColor: myUIColor, finalColor: myUIColor)`-> Aplica um padrão gradiente na view, baseado nas cores inicial e final.
 
 
 ----


 #### UITextField.swift

 * A extensão _UITextField_ é uma evolução do TextField para que o foco do próximo campo seja de acordo com a tag do campo atual + 1.
     
`myTextField.getNextResponder()` -> Retorna o UIView da próxima View baseado na próxima Tag.



----


#### Constants.swift

* O arquivo _Constants_ possui as constantes usadas no projeto.

`Lenght` -> define valores de tamanho de campos de cpf, cep, celular, etc

`Resources` -> define o nome das imagens usadas no aplicativo. 
 

 Exemplo de usos:

 `let image = Resources.resourceImageName` ->  retorna a UIImage com o nome _resourceImageName_


 ----


 #### BorderedButton.swift
 

* A classe _BorderedButton_ é uma especialização da classe _UIButton_ que ao ser utilizada, gera um botão com as bordas arredondadas. 

 ----

