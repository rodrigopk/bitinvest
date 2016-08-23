#me :)
User.create!(name:  "Rodrigo Vasconcelos",
             email: "rodrigopk@gmail.com",
             password:              "foobar",
             password_confirmation: "foobar",
             activated: true,
             activated_at: Time.zone.now)             

#coins
coins_array = JSON.load(open("https://api.coinmarketcap.com/v1/ticker/"))
    coins_array.each do |coin|
      new_coin = Coin.new(name: coin["name"],
                            tag: coin["id"],
                            symbol: coin["symbol"],
                            value: coin["price_usd"]||0.0,
                            volume: coin["24h_volume_usd"]||0.0,
                            market_cap: coin["market_cap_usd"]||0.0,
                            available_supply: coin["available_supply"]||0.0,
                            rank: coin["rank"],
                            is_fiat: false)
      new_coin.variations = { :hour => coin["percent_change_1h"]||0.0,
                              :day => coin["percent_change_24h"]||0.0,
                              :week => coin["percent_change_7d"]||0.0 }   
      new_coin.save!
      #creating coin statistics
      new_coin_statistics = CoinAverageStatistic.new(total_volume:0,
                                                      total_operations:0,
                                                      total_coin_views:0)
      new_coin.coin_average_statistic = new_coin_statistics
    end     
Coin.create(name: "Dolar",
            tag: "dolar",
            symbol: "USD", 
            value: 1.0, 
            volume: 0,
            market_cap:0,
            available_supply:0,
            is_fiat: true,
            rank: 9999) 

#wallets
user = User.first 
Coin.order(:rank)[0..9].each do |coin|
   user.wallets.create!(units: 10.0, coin_id: coin.id)   
end
user.wallets.create!(units: 10000.0, coin_id: Coin.last.id)  


# #questions
# Question.create(title: "O que é Bitcoin?")
# Question.last.answers.create!(text: "É uma rede que funciona de forma consensual onde foi possível criar uma nova forma de pagamento e também uma nova moeda completamente digital.",correct: true)
# Question.last.answers.create!(text: "É Uma forma de pagamento virtual, similar ao Paypal e PagSeguro, que depende de moedas correntes para funcionar.",correct: false)
# Question.last.answers.create!(text: "Uma rede de compartilhamento P2P",correct: false)
# Question.last.answers.create!(text: "Uma modalidade de investimento na bolsa de valores",correct: false)

# Question.create(title: "Quem controla a Bitcoin?")
# Question.last.answers.create!(text: "A Bitcoin é controlada pelo seu criador, Satoshi Nakamoto.",correct: false)
# Question.last.answers.create!(text: "A Bitcoin é controlada pelo FED",correct: false)
# Question.last.answers.create!(text: "A Bitcoin é controlada pela fundação Bitcoin",correct: false)
# Question.last.answers.create!(text: "A Bitcoin é controlada por todos os usuários do Bitcoin ao redor do mundo.",correct: true)

# Question.create(title: "Como são criados Bitcoins?")
# Question.last.answers.create!(text: "Novos bitcoins são gerados através de um processo competitivo e descentralizado chamado 'mineração'.",correct: true)
# Question.last.answers.create!(text: "Novos bitcoins são criadas baseados num algorítimo pseudo-aleatório chamado 'blockchain'.",correct: false)
# Question.last.answers.create!(text: "Novos bitcoins são gerados automaticamente toda sexta-feira as 16:20 GMT.",correct: false)
# Question.last.answers.create!(text: "O número de bitcoins disponíveis é fixo desde sua criação, e novos bitcoins não podem ser gerados.",correct: false)

# Question.create(title: "O que determina o preço do bitcoin?")
# Question.last.answers.create!(text: "O valor do dólar.",correct: false)
# Question.last.answers.create!(text: "Oferta e da demada.",correct: true)
# Question.last.answers.create!(text: "O padrão ouro.",correct: false)
# Question.last.answers.create!(text: "O valor de 12 camelos adultos.",correct: false)

# Question.create(title: "Quando foi publicado a primeira especificação do Bitcoin?")
# Question.last.answers.create!(text: "2011",correct: false)
# Question.last.answers.create!(text: "2009",correct: true)
# Question.last.answers.create!(text: "2012",correct: false)
# Question.last.answers.create!(text: "2001",correct: false)

# Question.create(title: "Qual o número máximo de Bitcoins que podem ser criadas?")
# Question.last.answers.create!(text: "32 milhões",correct: false)
# Question.last.answers.create!(text: "60 milhões",correct: false)
# Question.last.answers.create!(text: "9 milhões",correct: false)
# Question.last.answers.create!(text: "21 milhões",correct: true)

# Question.create(title: "O que é o Blockchain?")
# Question.last.answers.create!(text: "Um registro público que contém todas as transações de Bitcoins já processadas​​.",correct: true)
# Question.last.answers.create!(text: "O nome dado ao bloco dados de transações processados por um minerador para criar uma nova Bitcoin.",correct: false)
# Question.last.answers.create!(text: "O fórum de criptografia onde foi publicada a primeira especificação do Bitcoin.",correct: false)
# Question.last.answers.create!(text: "O conjunto de todas as bitcoins disponíveis no mercado.",correct: false)

# Question.create(title: "O que é uma carteira cryptocoin?")
# Question.last.answers.create!(text: "Um cartão de débito capaz de ser carregado com bitcoins.",correct: false)
# Question.last.answers.create!(text: "Um programa que armazena as chaves privadas para acessar cryptocoins.",correct: true)
# Question.last.answers.create!(text: "Uma conta criada no banco do instituto Bitcoin.",correct: false)
# Question.last.answers.create!(text: "Um arquivo de computador contendo cryptocoins.",correct: false)

# Question.create(title: "Como são chamados os computadores que realizam transações para a rede bitcoin?")
# Question.last.answers.create!(text: "Cypherpunks",correct: false)
# Question.last.answers.create!(text: "Satoshis",correct: false)
# Question.last.answers.create!(text: "Mineradores",correct: true)
# Question.last.answers.create!(text: "Processadores",correct: false)

# Question.create(title: "O Bitcoin é protegido por criptografia. A forma de criptografia usada é: ")
# Question.last.answers.create!(text: "Javascript",correct: false)
# Question.last.answers.create!(text: "MD-5",correct: false)
# Question.last.answers.create!(text: "Scrypt-N",correct: false)
# Question.last.answers.create!(text: "Sha256",correct: true)

# Question.create(title: "Qual foi a primeira cryptocoin a utilizar a criptografia Scrypt?")
# Question.last.answers.create!(text: "Namecoin",correct: false)
# Question.last.answers.create!(text: "Litecoin",correct: true)
# Question.last.answers.create!(text: "DogeCoin",correct: false)
# Question.last.answers.create!(text: "Bitcoin",correct: false)

# Question.create(title: "O que são Altcoins?")
# Question.last.answers.create!(text: "Expressão usada para se referir as moedas criptografadas que não o Bitcoin.",correct: true)
# Question.last.answers.create!(text: "Expressão usada para se referir as moedas criptografadas que usam criprografia Scrypt.",correct: false)
# Question.last.answers.create!(text: "Expressão usada para se referir as moedas criptografadas que valem menos de 1 dólar.",correct: false)
# Question.last.answers.create!(text: "Expressão usada para se referir as moedas criptografadas que não são aceitas no mercado.",correct: false)

# Question.create(title: "Qual dessas cryptocoins funciona também como uma rede de pagamentos?")
# Question.last.answers.create!(text: "Dogecoin",correct: false)
# Question.last.answers.create!(text: "Ethereum",correct: false)
# Question.last.answers.create!(text: "Ripple",correct: true)
# Question.last.answers.create!(text: "Litecoin",correct: false)

# Question.create(title: "Bitcoin é legal no Brasil?")
# Question.last.answers.create!(text: "Não, Bitcoins são ilegais e transações ou vendas em Bitcoins são passíveis de prisão.",correct: false)
# Question.last.answers.create!(text: "Não, Bitcoins são ilegais e transações ou vendas em Bitcoins são passíveis de multa.",correct: false)
# Question.last.answers.create!(text: "Sim, Bitcoins são legais e mas não podem ser utilizadas como forma de pagamento dentro do território.",correct: false)
# Question.last.answers.create!(text: "Sim, Bitcoins são legais e podem ser usadas como forma de pagamento dentro do território brasileiro.",correct: true)

# Question.create(title: "O que é um 'Majority hash rate attack'?")
# Question.last.answers.create!(text: "Um ataque direto a carteira de um usuário.",correct: false)
# Question.last.answers.create!(text: "A habilidade de uma pessoa de posse da maioria do hash rate de uma rede controlar o histórico de transações e evitar novas transações de serem confirmadas.",correct: true)
# Question.last.answers.create!(text: "Um ataque direcionado modificando os registros das transações de forma a obter o controle dos mineradores da rede.",correct: false)
# Question.last.answers.create!(text: "A habilidade de um grupo de mineradores impedir outros mineradores de obter bitcoins.",correct: false)

# Question.create(title: "O que é mineração de Bitcoin?")
# Question.last.answers.create!(text: "É o registro público que contém todas as transações de Bitcoins já processadas​​.",correct: false)
# Question.last.answers.create!(text: "A extração de novos bitcoins nas minas da Sumatra.",correct: false)
# Question.last.answers.create!(text: "O processo de gravação das informações relevantes a uma transação no blockchain.",correct: false)
# Question.last.answers.create!(text: "É o processo de usar capacidade de processamento para processar transações, garantir a segurança da rede, e manter todos participantes do sistema sincronizados.",correct: true)

# Question.create(title: "Bitcoin é vulnerável à computação quântica?")
# Question.last.answers.create!(text: "Sim, a maioria dos sistemas que dependem de criptografia em geral são, inclusive sistemas bancários tradicionais. ",correct: true)
# Question.last.answers.create!(text: "Não, o sistema distribuído da bitcoin foi projetado para ser imune a esses tipos de ataques.",correct: false)
# Question.last.answers.create!(text: "Sim, mas apenas as carteiras armazenadas na nuvem estariam vulneráveis.",correct: false)
# Question.last.answers.create!(text: "Não, a criptografia usada pela rede Bitcoin é imune a esse tipo de ataque.",correct: false)

# Question.create(title: "Qual a empresa por trás do Bitcoin?")
# Question.last.answers.create!(text: "SatoshiCo, a empresa fundada pelo grupo fundador do Bitcoin. ",correct: false)
# Question.last.answers.create!(text: "The Bitcoin foundation. ",correct: false)
# Question.last.answers.create!(text: "Não existe empresa por trás do Bitcoin, ele é controlado democraticamente por todos os usuários do fórum BitcoinTalk. ",correct: false)
# Question.last.answers.create!(text: "Não existe empresa por trás do Bitcoin, ele é controlado coletivamente por todos que executam o cliente Bitcoin.",correct: true)

# Question.create(title: "O que é uma chave privada?")
# Question.last.answers.create!(text: "Um código secreto que permite ao usuário provar a posse de suas Bitcoins",correct: true)
# Question.last.answers.create!(text: "Um código utilizado para o cancelamento de operações com Bitcoins.",correct: false)
# Question.last.answers.create!(text: "Um código secreto que permite que o usuário minere bitcoins.",correct: false)
# Question.last.answers.create!(text: "Um código utilizado para criar uma carteira Bitcoin.",correct: false)

# Question.create(title: "O que é um endereço Bitcoin?")
# Question.last.answers.create!(text: "Um endereço de email gratuito fornecido para todos os usuários da rede Bitcoin.",correct: false)
# Question.last.answers.create!(text: "Um endereço único que lhe permite receber Bitcoins.",correct: true)
# Question.last.answers.create!(text: "Um endereço de um estabelecimento comercial que aceita bitcoins como forma de pagamento.",correct: false)
# Question.last.answers.create!(text: "Um endereço de um site que lhe permite visualizar as informações da sua carteira.",correct: false)

# Question.create(title: "Operações com Bitcoins podem ser desfeitas?")
# Question.last.answers.create!(text: "Sim, uma transação pode ser cancelada até 1h depois de sua conclusão.",correct: false)
# Question.last.answers.create!(text: "Sim, uma transação pode ser cancelada até 24h depois de sua conclusão.",correct: false)
# Question.last.answers.create!(text: "Sim, mas apenas se os envolvidos pagarem o seguro extra da rede Bitcoin.",correct: false)
# Question.last.answers.create!(text: "Não, transações são irreversíveis.",correct: true)


# Question.create(title: "Alguém pode ser impedido de acessar a rede Bitcoin?")
# Question.last.answers.create!(text: "Sim, uma pessoa pode ser banida caso deixe de rodar o software da rede Bitcoin por mais de 6 meses.",correct: false)
# Question.last.answers.create!(text: "Não, ninguém pode impedir uma pessoa de interagir com a rede Bitcoin.",correct: true)
# Question.last.answers.create!(text: "Sim, uma pessoa pode ser banida da rede caso viole os termos e condições do contrato Bitcoin.",correct: false)
# Question.last.answers.create!(text: "Sim, mas apenas os membros da SatoshiCo podem banir usuários da rede.",correct: false)

# Question.create(title: "Quem tem acesso ao código fonte do Bitcoin?")
# Question.last.answers.create!(text: "Apenas o criador do bitcoin, Satoshi Nakamoto.",correct: false)
# Question.last.answers.create!(text: "Apenas aqueles que compram a licensa do software.",correct: false)
# Question.last.answers.create!(text: "Qualquer pessoa pode acessar o código fonte.",correct: true)
# Question.last.answers.create!(text: "Qualquer minerador da rede bitcoin.",correct: false)

# Question.create(title: "É possível rastrear transações feitas com bitcoins?")
# Question.last.answers.create!(text: "Sim, é possível rastrear transações analisando as informações na Blockchain.",correct: true)
# Question.last.answers.create!(text: "Não, a Bitcoin é completamente anônima.",correct: false)
# Question.last.answers.create!(text: "Não, a criptografia da rede é impenetrável.",correct: false)
# Question.last.answers.create!(text: "Sim, mas apenas se o usuário não marcar suas transações como anônimas.",correct: false)

# Question.create(title: "É possível realizar transações com bitcoins para usuários fora do país?")
# Question.last.answers.create!(text: "Sim, mas apenas mineradores podem realizar este tipo de operação.",correct: false)
# Question.last.answers.create!(text: "Sim, é possível enviar e receber bitcoins para qualquer lugar do mundo.",correct: true)
# Question.last.answers.create!(text: "Não, transações são limitadas aos países adjacentes ao país de origem do usuário.",correct: false)
# Question.last.answers.create!(text: "Não, transações são limitadas ao país de origem do emissor.",correct: false)

# Question.create(title: "Bitcoins podem ser armazenadas num disco local (HD,pendrive,etc)?")
# Question.last.answers.create!(text: "Sim, mas apenas em dispositivos vendidos pela SatoshiCo.",correct: false)
# Question.last.answers.create!(text: "Sim, podem ser mantidas em qualquer dispositivo de armazenamento.",correct: true)
# Question.last.answers.create!(text: "Não, bitcoins só podem ser armazenadas nos servidores da SatoshiCo.",correct: false)
# Question.last.answers.create!(text: "Não, bitcoins só podem ser armazenadas na nuvem.",correct: false)

# Question.create(title: "O que acontece quando bitcoins são perdidos?")
# Question.last.answers.create!(text: "Quando um usuário perde a carteira, o valor perdido é distribuído entre os usuários.",correct: false)
# Question.last.answers.create!(text: "Quando um usuário perde a carteira, o valor é recuperado mediante o pagamento de uma taxa a SatoshiCo.",correct: false)
# Question.last.answers.create!(text: "Quando um usuário perde a carteira, o valor é recuperado assim que o usuário se reconecta a rede Bitcoin.",correct: false)
# Question.last.answers.create!(text: "Quando um usuário perde a carteira, suas bitcoins são retiradas de circulação.",correct: true)

# Question.create(title: "Como são processados os dados do Bitcoin")
# Question.last.answers.create!(text: "De forma descentralizada, em vários servidores espalhados nas sedes da SatoshiCo.",correct: false)
# Question.last.answers.create!(text: "De forma centralizada, num supercomputador localizado na base do Bitcoin.",correct: false)
# Question.last.answers.create!(text: "De forma descentralizada, por todos os usuários do cliente Bitcoin.",correct: true)
# Question.last.answers.create!(text: "De forma centralizada, num supercomputador localizado no Fort Knox.",correct: false)

# Question.create(title: "O que é o Proof of Work?")
# Question.last.answers.create!(text: "Um prêmio entregue a todos os usuários que mineram bitcoins pela primeira vez.",correct: false)
# Question.last.answers.create!(text: "A competição entre mineradores para encontrar a hash correta.",correct: true)
# Question.last.answers.create!(text: "O recibo eletrônico gerado após cada transação em Bitcoin.",correct: false)
# Question.last.answers.create!(text: "O recibo eletrônico gerado após cada bloco Bitcoin minerado.",correct: false)

