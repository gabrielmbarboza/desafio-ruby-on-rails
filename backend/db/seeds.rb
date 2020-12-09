# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ label: 'Star Wars' }, { label: 'Lord of the Rings' }])
#   Character.create(label: 'Luke', movie: movies.first)

transaction_types = [
  { label: 'Débito', code: 1, operation: 'C' },
  { label: 'Boleto', code: 2, operation: 'D' },
  { label: 'Financiamento', code: 3, operation: 'D' },
  { label: 'Crédito', code: 4, operation: 'C' },
  { label: 'Recebimento Empréstimo', code: 5, operation: 'C' },
  { label: 'Vendas	Entrada', code: 6, operation: 'C' },
  { label: 'Recebimento TED', code: 7, operation: 'C' },
  { label: 'Recebimento DOC', code: 8, operation: 'C' },
  { label: 'Aluguel', code: 9, operation: 'D' }]

  TransactionType.create!(transaction_types)