# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

transaction_types = [
  { name: 'Débito', operation: 'C' },
  { name: 'Boleto', operation: 'D' },
  { name: 'Financiamento', 	operation: 'D' },
  { name: 'Crédito', 	operation: 'C' },
  { name: 'Recebimento Empréstimo', operation: 'C' },
  { name: 'Vendas	Entrada', operation: 'C' },
  { name: 'Recebimento TED', operation: 'C' },
  { name: 'Recebimento DOC', operation: 'C' },
  { name: 'Aluguel', operation: 'D' }]

  TransactionType.create(transaction_types)