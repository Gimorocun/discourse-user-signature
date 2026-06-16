import Component from "@glimmer/component";
import UserSignature from "../../components/user-signature";
import { getSignatureValue, signatureFieldKey } from "../../lib/signature-field";

export default class AfterUserNameUserSignature extends Component {
  static shouldRender(args) {
    if (!signatureFieldKey()) {
      return false;
    }

    return !!getSignatureValue(args.user);
  }

  <template>
    <UserSignature @user={{@user}} @displayType="inline" />
  </template>
}
