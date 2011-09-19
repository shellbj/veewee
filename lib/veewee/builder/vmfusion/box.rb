require 'veewee/builder/core/box'
require 'veewee/builder/core/box/vnc'

require 'veewee/builder/vmfusion/helper/template'
require 'veewee/builder/vmfusion/helper/create'
require 'veewee/builder/vmfusion/export_ova'


module Veewee
  module Builder
    module Vmfusion
      class Box < Veewee::Builder::Core::Box

        include ::Veewee::Builder::Vmfusion::BoxHelper
        include ::Veewee::Builder::Core::BoxCommand


        def initialize(name,env)

          require 'fission'

          super(name,env)
        end

        def create(definition)
          create_vm(definition)
          create_disk(definition)
        end

        def start(mode)
          # mode can be gui or nogui
          raw.start unless raw.nil?
        end

        def stop
          raw.stop unless raw.nil?
        end

        def halt
          raw.halt unless raw.nil?
        end

        def shutdown
          raw.shutdown unless raw.nil?
        end

        def destroy
          raw.halt if raw.state=="running"
          ::Fission::VM.delete(name)
        end

        # Check if box is running
        def ready?
          return @raw.ready?
        end

        # Check if the box already exists
        def exists?
          return raw.exists?
        end

        # Get the IP address of the box
        def ip_address
          return raw.ip_address
        end

        # Type on the console
        def console_type(sequence,type_options={})
#          vnc_port=raw.vnc_port
          vnc_port=20
          vnc_type(sequence,"localhost",vnc_port)
        end

        private
        def raw
          @raw=::Fission::VM.new(name)
        end

      end # End Class
    end # End Module
  end # End Module
end # End Module
