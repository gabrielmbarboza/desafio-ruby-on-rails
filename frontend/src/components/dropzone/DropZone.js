import React, { useState } from 'react';
import './DropZone.css';
import imgFileBox from '../../img_457955.png';
import CnabService from '../../services/cnab-service';

const DropZone = () => {
  const [cnab, setCnab] = useState([]);
  const [subtitle, setSubtitle] = useState(["O arquivo deve respeitar o formato CNAB"]);

  const dragOver = (e) => {
    e.preventDefault();
  }
  
  const dragEnter = (e) => {
    e.preventDefault();
  }
  
  const dragLeave = (e) => {
    e.preventDefault();
  }
  
  const fileDrop = (e) => {
    e.preventDefault();
    const files = e.dataTransfer.files;
    if(files.length) {
      handleFile(files);
    }
  }
  
  const handleFile = async(files) => {
    const cnabFile = files[0];
    const cnab64 = await toBase64(cnabFile);
    
    setSubtitle(`Deseja realmente enviar o arquivo ${cnabFile.name}?`);
    setCnab(cnab64);
  }
  
  const validateFile = (file) => {
    const validTypes = ['text/plain'];
    if (validTypes.indexOf(file.type) === -1) {
        return false;
    }
    return true;
  }
  
  const toBase64 = file => new Promise((resolve, reject) => {
    const reader = new FileReader();
    reader.readAsDataURL(file);
    reader.onload = () => resolve(reader.result);
    reader.onerror = error => reject(error);
  });
  
  const uploadCnab = () => {
    const formData = new FormData();
    formData.append('cnab', cnab);
    setSubtitle("Arquivo enviado com sucesso!")
    CnabService.uploadCnab(formData);
  } 

  return (
    <>
      <div className="file-box-text">
        <span className="file-box-title">Envie seu arquivos</span>
        <br />
        <span className="file-box-subtitle">{subtitle}</span>
      </div> 
      <div className="file-box" 
          onDragOver={dragOver}
          onDragEnter={dragEnter}
          onDragLeave={dragLeave}
          onDrop={fileDrop}>
          <div className="file-box-text-img">
            <img src={ imgFileBox }/>  
          </div>
          <br />  
          <div className="file-box-text-drag">Arraste e solte seu arquivo aqui.</div>
          <br />
          <div className="file-box-text-click">Clique para navegar no seu disco local</div>
      </div>
      <button className="dropzone-button" onClick={() => uploadCnab()}>
        Enviar Transa&ccedil;&otilde;es
      </button>
    </>
  )
}

export default DropZone;