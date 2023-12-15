const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

exports.sendNotification = functions.https.onCall(async (data, context) => {
  const adminDeviceToken = "<ADMIN_DEVICE_TOKEN>";
  const message = {
    token: adminDeviceToken,
    notification: {
      title: "Nouvelle commande de voiture",
      body: "Une nouvelle commande de voiture a été passée.",
    },
    data: {
      // Vous pouvez ajouter des données supplémentaires ici si nécessaire
    },
  };

  await admin.messaging().send(message);
});
