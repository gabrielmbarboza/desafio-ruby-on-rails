import React from 'react';
import DropZone from './components/dropzone/DropZone';
import ImageMain from './image_480x480.jpg';
import logo from './logo.png';
import './App.css';
import { Link } from 'react-router-dom'

function App() {
  return (
    <div className="container">
      <header>
        <img src={logo} />
        <nav>
          <ul className="menu">
            <li><Link to="/"><strong>Importar</strong></Link></li>
            <li><Link to="/transactions">Transa&ccedil;&otilde;es</Link></li>
            <li><a href="#">Sobre</a></li>
            <li><a href="#">Ajuda</a></li>
          </ul>
        </nav>
      </header>
      <main>
        <img src={ImageMain} />
      </main>
      <aside>
        <DropZone />
      </aside>
      <footer></footer>
    </div>
  );
}

export default App;
