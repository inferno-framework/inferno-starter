module InfernoStarter
  class ExampleSequence < Inferno::Sequence::SequenceBase
    title 'Example Sequence'

    description 'An Example Sequence'

    details %( The Example Sequence provides an example of a sequence. It provides a couple tests and can even be used
               to retrieve a patient resource from the FHIR Server.)

    test_id_prefix 'example'

    requires :patient_id

    test :todo do
      metadata do
        id '01'
        name 'A todo test that does nothing'
        link 'http://example.com'
        description %(
          todo tests like this one typically don't do anything.
                    )
      end
      todo
    end

    test :read_patient do
      metadata do
        id '02'
        name 'Read the patient from the FHIR server'
        link 'http://example.com'
        description %(
          Reads the patient from the FHIR server.  Checks for a successful response.
        )
      end
      @client.set_no_auth

      reply = @client.read(versioned_resource_class('Patient'), @instance.patient_id)
      @client.set_bearer_token(@instance.token)
      assert_response_ok reply
    end
  end
end