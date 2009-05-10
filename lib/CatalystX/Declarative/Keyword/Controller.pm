use MooseX::Declare;

class CatalystX::Declarative::Keyword::Controller 
    extends MooseX::Declare::Syntax::Keyword::Class
    with    CatalystX::Declarative::DefaultSuperclassing {


    use MooseX::MethodAttributes ();
    use aliased 'CatalystX::Declarative::Keyword::Action', 'ActionKeyword';
    use aliased 'CatalystX::Declarative::Controller::RegisterActionRoles';
    use aliased 'CatalystX::Declarative::Controller::DetermineActionClass';


    before add_namespace_customizations (Object $ctx, Str $package) {

        MooseX::MethodAttributes->init_meta(for_class => $package);
        $ctx->add_preamble_code_parts(
            'use CLASS',
            sprintf('with qw( %s )', join ' ',
                RegisterActionRoles,
                DetermineActionClass,
            ),
        );
    }

    method default_superclasses { 'Catalyst::Controller' }

    around default_inner () {

        return [ 
            @{ $self->$orig() || [] },
            ActionKeyword->new(identifier => 'action'),
            ActionKeyword->new(identifier => 'under'),
            ActionKeyword->new(identifier => 'final'),
        ];
    }
}
