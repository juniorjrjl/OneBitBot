module FaqModule

    class CreateService

        def initialize(params)
            @question = params['question']
            @answer = params['answer']
            @hashtags = params['hashtags']
        end

        def call
            return 'Hashtag Obrigatória' if @hashtags == nil
            Faq.transaction do
                faq = Faq.create(question: @question, answer: @answer)
                @hashtags.split(/[\s,]+/).each do |h|
                    faq.hashtags << Hashtag.find_or_create_by(name: h)
                end
            end
            'Criada com sucesso'
        end

    end

end