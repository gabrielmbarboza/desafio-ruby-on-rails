import React, { useState, useEffect } from 'react';
import './SelectTransaction.css';
import CnabService from '../../services/cnab-service';

const SelectTransaction = () => { 
  const [stores, setStores] = useState([]);

  useEffect(() => {
    (async () =>  {
      const data = await CnabService.getStores();
      setStores(data);
    })(); 
  }, []);

  return(
    <select id="stores">
      {stores.map((store) => (
        <option value={store.id}>{store.name}</option>
      ))}
    </select>
  );
}

export default SelectTransaction;