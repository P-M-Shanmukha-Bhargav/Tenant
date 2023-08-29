export const environment = {
    production: true,
    firebase: {
        apiKey: "AIzaSyClPZIpVrV7XkXwJ1dUSyEMuGTa_gkEpws",
        authDomain: "tenantapp-dev.firebaseapp.com",
        projectId: "tenantapp-dev",
        storageBucket: "tenantapp-dev.appspot.com",
        messagingSenderId: "113207441797",
        appId: "1:113207441797:web:97733b7e20ec81e6d1ecec"
    },
    apiURL: "https://localhost:44303/api",
    payment: {
        key: "FIpoBI",
        salt: "1FTv3xxE",
        action: "https://secure.payu.in/_payment",
        surl: "/Tenant/UpdatePaymentTransactionStatus",
        furl: "/Tenant/UpdatePaymentTransactionStatus"
    }
};
