use MooseX::Declare;

class CatalystX::Declarative extends MooseX::Declare {

    use aliased 'CatalystX::Declarative::Keyword::Controller', 'ControllerKeyword';

    around keywords {
        $self->$orig,
        ControllerKeyword->new(identifier => 'controller'),
    }
}

