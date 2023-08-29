import { Login } from "./login";

export interface Register extends Login {
    displayName: string;
    phoneNumber: string;
    aadharNumber: string;
    upiId: string;
}
