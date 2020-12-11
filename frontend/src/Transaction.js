import React from 'react';
import logo from './logo.png';
import './Transaction.css';
import { Link } from 'react-router-dom'
import CnabService from './services/cnab-service';
import SelectTransation from './components/select-transaction/SelectTransaction';

class Transaction extends React.Component {
  state = {
    transactions: []
  }

  async componentDidMount() {
    const transactions = await CnabService.getTransactions();
    this.setState(transactions);
  };

  async getTransactions() {
    const select = document.getElementById('stores');
    const options = Array.from(select.options);
    const selectedOption = options.find((option) => option.selected);
    const {value: storeId} = selectedOption;
    const _transactions = await CnabService.getTransactions(storeId);
    this.setState(_transactions);
  }

  render() {
    const { store_name, store_owner, balance, balance_status, transactions } = this.state;
  
    return(
     <div className="transactions-container">
      <header>
        <img src={logo} />
        <nav>
          <ul className="menu">
            <li><Link to="/">Importar</Link></li>
            <li><Link to="/transactions"><strong>Transa&ccedil;&otilde;es</strong></Link></li>
            <li><a href="#">Sobre</a></li>
            <li><a href="#">Ajuda</a></li>
          </ul>
        </nav>
      </header>
      <main className="transactions">
        <div className="owner-box">
          <SelectTransation />
          <button className="button" onClick={() => this.getTransactions()}>Exibir Transa&ccedil;&otilde;es</button>
        </div>
        <div className="owner-info">
          <div className="owner-info-text">
            <div>Transações Bancárias: <strong>{store_name}</strong></div>
            <div>Representante: <strong>{store_owner}</strong></div>
          </div>
          <div>
            <span>
              Total: <strong className={balance_status}>{balance}</strong>
            </span>
          </div>
        </div>
        <div className="transactions-table">
          <table>
            <thead>
              <tr>
                <th>Tipo</th>
                <th>Data</th>
                <th>Hora</th>
                <th>Valor</th>
                <th>Cliente</th>
                <th>Cart&atilde;o Cr&eacute;dito</th>
              </tr>
            </thead>
            <tbody>
              {transactions.map((transaction, idx) => (
                <tr key={transaction.id} className={ idx % 2 != 0 ? 'odd': ''}>
                  <td>{transaction.type}</td>
                  <td>{transaction.transaction_date}</td>
                  <td>{transaction.transaction_hour}</td>
                  <td>{transaction.amount}</td>
                  <td>{transaction.itr}</td>
                  <td>{transaction.creditcard}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </main>
      <footer></footer>
    </div>
    )}
}

export default Transaction;
