importScripts("https://www.gstatic.com/firebasejs/8.6.1/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.6.1/firebase-messaging.js");

var firebaseConfig = {
    apiKey: "AIzaSyDdgAo5aM9-8efyKKZiuNOznEpWSJUi3zY",
    authDomain: "task-notification-f4159.firebaseapp.com",
    databaseURL: "https://task-notification-f4159.firebaseio.com",
    projectId: "task-notification-f4159",
    messagingSenderId: '719385582416',
    storageBucket: "task-notification-f4159.appspot.com",
    appId: "1:719385582416:android:d4734aa737ccf6ca73aa55",
};
firebase.initializeApp(firebaseConfig);

const messaging = firebase.messaging();