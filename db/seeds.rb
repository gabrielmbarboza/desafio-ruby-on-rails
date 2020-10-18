# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

transaction_types = [
  { name: 'Débito', code: 1, operation: 'C' },
  { name: 'Boleto', code: 2, operation: 'D' },
  { name: 'Financiamento', 	code: 3, operation: 'D' },
  { name: 'Crédito', 	code: 4, operation: 'C' },
  { name: 'Recebimento Empréstimo', code: 5, operation: 'C' },
  { name: 'Vendas	Entrada', code: 6, operation: 'C' },
  { name: 'Recebimento TED', code: 7, operation: 'C' },
  { name: 'Recebimento DOC', code: 8, operation: 'C' },
  { name: 'Aluguel', code: 9, operation: 'D' }]

  TransactionType.create!(transaction_types)