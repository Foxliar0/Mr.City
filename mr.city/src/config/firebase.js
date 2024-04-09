import { initializeApp } from 'firebase/app';
import { getAuth } from 'firebase/auth';
import { getFirestore } from 'firebase/firestore';
import { getStorage } from 'firebase/storage';

const firebaseConfig = {
    apiKey: "AIzaSyDUBVosdRxXaIdKlEzEeYqBg1nPWxJq9AY",
    authDomain: "mr-city-2fe7c.firebaseapp.com",
    projectId: "mr-city-2fe7c",
    storageBucket: "mr-city-2fe7c.appspot.com",
    messagingSenderId: "722505957254",
    appId: "1:722505957254:web:a4fff1c94e05290c2db607",
    measurementId: "G-ZP6T84R2X8"
};

const app = initializeApp(firebaseConfig);
export const auth = getAuth(app);
export const db = getFirestore(app);
export const storage = getStorage(app); 