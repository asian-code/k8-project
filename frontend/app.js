import React, { useEffect, useState } from 'react';
import axios from 'axios';

function App() {
  const [status, setStatus] = useState('Loading...');

  useEffect(() => {
    axios.get('http://localhost:8000/api/health/')
      .then(response => {
        setStatus(response.data.status);
      })
      .catch(error => {
        setStatus('Error connecting to backend');
      });
  }, []);

  return (
    <div className="App">
      <h1>Django + React App</h1>
      <p>Backend Status: {status}</p>
    </div>
  );
}

export default App;