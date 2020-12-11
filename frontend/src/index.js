import React from 'react';
import ReactDOM from 'react-dom';
import {
  BrowserRouter as Router,
  Switch,
  Route
} from "react-router-dom";
import './index.css';
import App from './App';
import Transaction from './Transaction';

ReactDOM.render(
  <Router>
      <Switch>
          <Route path="/" exact={true} component={App} />
          <Route path="/transactions" component={Transaction} />
      </Switch>
  </ Router>
  , document.getElementById('root'));
