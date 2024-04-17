import "./login.css";
import { FaUser } from "react-icons/fa";
import { FaLock } from "react-icons/fa";
import { getAuth, signInWithEmailAndPassword } from "firebase/auth";
import { useState } from "react";
import { useNavigate } from "react-router-dom";

const Login = () => {

  const [email,setEmail] = useState('')
  const [password,setPassword] = useState('')
  const navigate = useNavigate()

  const Handlesubmit = (e) => {
    e.preventDefault()
    const auth = getAuth();
    signInWithEmailAndPassword(auth, email, password)
      .then((userCredential) => {
     
        if(userCredential.user){
          navigate('/dashboard')
        }
       
      })
      .catch((error) => {
        const errorCode = error.code;
        const errorMessage = error.message;
        if(errorMessage === "Firebase: Error (auth/invalid-email).")
        alert("Invalid Credential")
      });
  };
  return (
    <div className="body">
      <div className="wrapper">
        <form action="" onSubmit={Handlesubmit}>
          <h1>Login</h1>
          <div className="input-box">
            <input type="text" placeholder="Email" onChange={(e) => setEmail(e.target.value)} required />
            <FaUser className="icon" />
          </div>
          <div className="input-box">
            <input type="password" placeholder="password" onChange={(e) => setPassword(e.target.value)} required />
            <FaLock className="icon" />
          </div>
          <div className="remember-forgot">
            <label>
            </label>
          </div>
          <button type="submit">Login</button>
          <div className="register-link">
          </div>
        </form>
      </div>
    </div>
  );
};

export default Login;
