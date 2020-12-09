# Desafio Ruby On Rails

> App de importação de dados no formato CNAB.

O desafio consiste em importar dados de um arquivo de texto no formato [CNAB](https://blog.tecnospeed.com.br/padroes-de-remessa-e-de-retorno/) que visa criar um intercâmbio de Informações entre Bancos e Empresas.

## Projeto

O projeto está divido em dois diretórios:

### Backend

Api Rails que fornece endpoints para importação do arquivo no formato CNAB.

### Frontend

App React responsável por manipular o arquivo no formato CNAB e enviá-lo para Api.

## Instalação

**Usando Docker & docker-compose**

Construindo a image do projeto com o comando build:  
`docker-compose build app`

A partir da versão 5.2 do Rails, foi introduzido a ferramenta [Credentials](https://edgeguides.rubyonrails.org/security.html#environmental-security). Para gerar a SECRET_BASE_KEY, é necessário executar o seguinte comando:  
`docker-compose run --rm -e EDITOR=vim cnab bin/rails credentials:edit`

Execute a task para criar o banco de dados da Api:  
`docker-compose run --rm cnab rails db:setup`

Execute o comando up para subir a aplicação:  
`docker-compose up app`

![](https://memegenerator.net/img/instances/82338138.jpg)

## Rodando os testes

`docker-compose run -e "RAILS_ENV=test" --rm cnab bundle exec rspec`