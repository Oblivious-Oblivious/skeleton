class Object
    def methods
        {{ @type.methods.map &.name.stringify }};
    end
end
