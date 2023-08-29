export const environment = {
    production: false,
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
        key: "gtKFFx",
        salt: "4R38IvwiV57FwVpsgOvTXBdLE4tHUXFW",
        action: "https://test.payu.in/_payment",
        surl: "/Tenant/UpdatePaymentTransactionStatus",
        furl: "/Tenant/UpdatePaymentTransactionStatus"
    }
};
