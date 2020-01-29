Um guia de estilo e convenções de programação para nossos projetos em Swift

Esta é uma tentativa de incentivar padrões para alcançar os seguintes objetivos (mais ou menos em ordem de prioridade):

 1. Maior rigor e diminuição da probabilidade de erro do programador
 1. Aumento da clareza de intenção
 1. Verbosidade reduzida
 1. Menos debates sobre estética

Se você tiver sugestões sempre nos conte, elas são sempre bem-vindas. Assim podemos sempre evoluir nos nossos processos resultando e mais qualidade nas nossas entregas.

----

#### Espaços em branco

 * Tabs, não espaços.
 * Termine arquivos com novas linhas.
 * Use espaços em branco verticais quando necessário para dividir o código em blocos lógicos.
 * Não deixe espaços em branco no final das linhas
   * Nem mesmo indentação em linhas em branco.

#### Prefira `let`-bindings a ` var`-bindings sempre que possível

Use `let foo = ...` ao invés de `var foo = ...` sempre que possível (e em caso de dúvida). Só use `var` se for absolutamente necessário (isto é, você *sabe* que o valor pode mudar, por exemplo, quando se utiliza o modificador de armazenamento `weak`).

_Justificativa:_ A intenção e o significado de ambas palavras-chave são claros, mas *let-como-padrão* resulta em código mais seguro e mais claro.

Um `let`-binding garante e *sinaliza claramente para o programador* que seu valor nunca vai mudar. Código subseqüente pode assim fazer suposições mais fortes sobre seu uso.

Torna-se mais fácil raciocinar sobre o código. Se você tivesse usado `var` enquanto  supondo que o valor nunca muda, teria que verificar manualmente isso.

Assim, sempre que você vir um identificador `var` sendo usado, suponha que ele vai mudar e se pergunte o porquê.

#### Retorno e sair mais cedo

Quando você tem que atender a certos critérios para continuar a execução, tente sair o mais cedo possível. Assim, em vez disto:

```swift
if n.isNumber {
    // Use n aqui
} else {
    return
}
```

use isto:
```swift
guard n.isNumber else {
    return
}
// Use n aqui
```

Você também pode fazer isso com uma declaração `if`, mas é preferível usar `guard` porque uma declaração `guard` sem `return`, `break` ou `continue` produz um erro de compilação. Logo, a saída é garantida.

#### Evite usar _Unwrapping_ forçado de Opcionais

Se você tem um identificador `foo` do tipo `FooType?` ou `FooType!`, se possível não use unwrapping forçado para chegar ao valor subjacente (`foo!`). Em vez de forçar, é preferível:

```swift
if let foo = foo {
    // Use o valor de `foo` unwrapped aqui
} else {
    // Se necessário, tratar o caso em que o opcional é nil
}
```

Alternativamente, você pode querer usar encadeamento de opcionais em alguns desses casos, por exemplo:

```swift
// Chamar a função se `foo` não é nil. Se `foo` é nil, ignorar que já tentou fazer a chamada
foo?.callSomethingIfFooIsNotNil ()
```

_Justificativa:_ Uso explícito de `if let`-binding para opcionais resulta em código mais seguro. _Unwrapping_ forçado é mais propenso a causar erros em tempo de execução.

#### Evite usar Opcionais _Unwrapped_ Implicitamente

Sempre que possível, use `let foo: FooType?` ao invés de `let foo:FooType!` se `foo` pode ser `nil` (Note-se que, em geral, `?` pode ser usado ao invés de `!`).

_Justificativa:_ Opcionais explícitos resultam em código mais seguro. Opcionais _unwrapped_ implicitamente têm o potencial de produzir erros em tempo de execução.

#### Prefira _getters_ implícitos nas propriedades e _subscripts_ somente leitura.

Quando possível, omita a palavra-chave `get` em propriedades somente-leitura computadas automaticamente e _subscripts_ somente leitura.

Então, escreva assim:

```swift
var myGreatProperty: Int {
    return 4
}

subscript(index: int) -> T {
    return objects[index]
}
```

... e não assim:

```swift
var myGreatProperty: Int {
    get {
        return 4
    }
}

subscript(index: int) -> T {
    get {
        return objects[index]
    }
}
```

_Justificativa:_ A intenção e o significado da primeira versão são claros e resultam em menos código.

#### Sempre especifique o controle de acesso explicitamente para as definições de nível superior

Funções, tipos e variáveis de nível superior devem sempre ter especificadores de controle de acesso explícitos:

```swift
public var whoopsGlobalState: Int
internal struct TheFez {}
private func doTheThings(things: [Thing]) {}
```

No entanto, as definições dentro destes podem deixar o controle de acesso implícito, onde apropriado:

```swift
internal struct TheFez {
    var owner: Person = Joshaber()
}
```

_Justificativa:_ É raro que definições de nível superior sejam especificamente `internal` e ser explícito garante que essa decisão só é tomada de forma pensada. Dentro de uma definição, reutilizar o mesmo especificador de controle de acesso é duplicação de esforço e o padrão é geralmente razoável.

#### Ao especificar um tipo, sempre associar os dois pontos (`:`) ao identificador

Ao especificar o tipo de um identificador, coloque sempre os dois pontos imediatamente
após o identificador, seguido por um espaço e, em seguida, o nome do tipo.

```swift
classe SmallBatchSustainableFairtrade: Coffee {...}

let timeToCoffee: NSTimeInterval = 2

func makeCoffee (tipo: CoffeeType) -> Coffee {...}
```

_Justificativa:_ O especificador de tipo diz algo sobre o _identificador_ e deve ser posicionado junto a ele.

Além disso, ao especificar o tipo de um dicionário, sempre coloque os dois pontos imediatamente após o tipo da chave, seguido por um espaço e, em seguida, o tipo de valor.

```swift
let capitals: [Country: City] = [ Sweden: Stockholm ]
```

#### Somente se refira a `self` explicitamente quando necessário

Ao acessar propriedades ou métodos em `self`, deixe a referência ao `self` implícita por padrão:

```swift
private class History {
    var events: [Event]

    func rewrite () {
        events = []
    }
}
```

Só inclua a palavra-chave explícita quando isso for requerido pela linguagem-por exemplo, em um closure ou quando há conflito com os nomes de parâmetros:

```swift
extension History {
    init (events: [Event]) {
        self.events = events
    }

    var whenVictorious: () -> () {
        return {
            self.rewrite ()
        }
    }
}
```

_Justificativa:_ Isso faz com que a semântica de captura de `self` se destaque mais em closures e evita a verbosidade em outros lugares.

#### Prefira `struct` a `class`

A menos que você necessite de funcionalidade que só pode ser fornecida por uma classe (como identidade ou des-inicializadores), dê preferência a implementar um `struct`.

Note-se que a herança (por si só) normalmente _não é_ uma boa razão para usar as classes porque o polimorfismo pode ser fornecido por protocolos e reutilização de implementações pode ser fornecida através de composição.

Por exemplo, esta hierarquia de classes:

```swift
class Vehicle {
    let numberOfWheels: Int

    init (numberOfWheels: int) {
        self.numberOfWheels = numberOfWheels
    }

    func maximumTotalTirePressure (pressurePerWheel: Float) -> Float {
        return pressurePerWheel * float (numberOfWheels)
    }
}

class Bycicle: Vehicle {
    init() {
        super.init(numberOfWheels: 2)
    }
}

class Car: Vehicle {
    init() {
        super.init(numberOfWheels: 4)
    }
}
```

poderia ser refatorada nestas definições:

```swift
protocol Vehicle {
    var numberOfWheels: Int {get}
}

func maximumTotalTirePressure (vehicle: Vehicle, pressurePerWheel: Float) -> Float {
    return pressurePerWheel * float (vehicle.numberOfWheels)
}

struct Bicycle: Vehicle {
    let numberOfWheels = 2
}

struct Car: Vehicle {
    let numberOfWheels = 4
}
```
    
_Justificativa:_ Tipos de valor (ao invés de referência) são mais simples, mais fáceis de raciocinar sobre e se comportam conforme o esperado com a palavra-chave `let`.

#### Torne classes `final` por padrão

Classes devem começar como `final` e só podem ser alteradas para permitir subclasses se uma necessidade válida para herança for identificada. Mesmo neste caso, tantas definições quanto possível _dentro_ da classe devem ser `final`, seguindo as mesmas regras.

_Justificativa:_ A composição é geralmente preferível à herança e espera-se que a _escolha_ de usar herança seja pensada com cuidado.

#### Omita parâmetros de tipo sempre que possível

Métodos de tipos parametrizados podem omitir parâmetros de tipo no tipo de recepção quando eles são idênticos aos do receptor. Por exemplo:

```swift
struct Composite <T> {
    ...
    func compose(other: Composite<T>) -> Composite<T> {
        return Composite<T> (self, other)
    }
}
```

poderia ser reescrita como:

```swift
struct Composite <T> {
    ...
    func compose (other: Composite) -> Composite {
        return Composite (self, other)
    }
}
```

_Justificativa:_ Omitir parâmetros de tipo redundantes clarifica a intenção e torna óbvio o caso contrário, quando o tipo retornado recebe parâmetros de diferentes tipos.

#### Use espaços em branco a redor de definições de operador

Use espaços em branco ao redor de operadores quando defini-los. Ao invés de:

```swift
func <|(lhs: Int, rhs: Int) -> Int
func <|<<A>(lhs: A, rhs: A) -> A
```

Escreva:

```swift
func <| (lhs: Int, rhs: Int) -> Int
func <|< <A>(lhs: A, rhs: A) -> A
```

_Justificativa:_ Operadores consistem em caracteres de pontuação, o que pode torná-los difíceis de ler quando imediatamente seguidos pela pontuação para uma lista de parâmetros de tipo ou valor. Adicionar o espaço em branco separa os dois mais claramente.
