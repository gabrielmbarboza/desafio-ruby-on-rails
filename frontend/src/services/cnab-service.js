import axios from 'axios';

class CnabService {
  constructor() {
    this.baseUrl = 'http://0.0.0.0:3000';
  }
  
  async getTransactions(storeId = 1) {
    const { data } = await axios.get(`${this.baseUrl}/transactions?store_id=${storeId}`);
    return data;
  }

  async getStores() {
    const { data: stores } = await axios.get(`${this.baseUrl}/stores`);
    return stores;
  }

  uploadCnab(formData) {
    return axios.post(`${this.baseUrl}/transactions/upload`, formData, {});
  }
}

export default new CnabService();