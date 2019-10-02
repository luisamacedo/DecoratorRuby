# A interface do componente base define operações que podem ser
# alteradas pelos decoradores.
class Component
  # @return [String]
  def operation
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

# Componentes concretos fornecem implementações padrão das operações. 
# Pode haver várias variações dessas classes.
class ConcreteComponent < Component
  # @return [String]
  def operation
    'ConcreteComponent'
  end
end

# A classe Decorator base segue a mesma interface que os outros componentes.
# O objetivo principal desta classe é definir a interface de empacotamento para
# todos os decorators de concreto. A implementação padrão do código de quebra automática
# pode incluir um campo para armazenar um componente quebrado e os meios para inicializá-lo.
class Decorator < Component
  attr_accessor :component

  # @param [Component] component
  def initialize(component)
    @component = component
  end

  # O Decorador delega todo o trabalho para o componente agrupado.
  def operation
    @component.operation
  end
end

# Decoradores de concreto chamam o objeto embrulhado e alteram seu resultado de alguma maneira.
class ConcreteDecoratorA < Decorator
  # Os decoradores podem chamar a implementação pai da operação, em vez de chamar o objeto
  # empacotado diretamente. Essa abordagem simplifica a extensão das classes decoradoras.
  def operation
    "ConcreteDecoratorA(#{@component.operation})"
  end
end

# Os decoradores podem executar seu comportamento antes ou depois da chamada 
# para um objeto quebrado.
class ConcreteDecoratorB < Decorator
  # @return [String]
  def operation
    "ConcreteDecoratorB(#{@component.operation})"
  end
end

# O código do cliente funciona com todos os objetos usando a interface Component. Dessa forma,
# ele pode permanecer independente das classes concretas de componentes com os quais trabalha.
def client_code(component)
  # ...

  print "RESULTADO: #{component.operation}"

  # ...
end

# Dessa forma, o código do cliente pode suportar os dois componentes simples...
simple = ConcreteComponent.new
puts 'Cliente: Eu tenho um componente simples:'
client_code(simple)
puts "\n\n"

# ...bem como os decorados.
#
# Observe como os decoradores podem envolver não apenas componentes simples,
# mas também os outros decoradores.
decorator1 = ConcreteDecoratorA.new(simple)
decorator2 = ConcreteDecoratorB.new(decorator1)
puts 'Cliente: Agora eu tenho um componente decorator:'
client_code(decorator2)