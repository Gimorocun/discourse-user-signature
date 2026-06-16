import Component from "@glimmer/component";
import { apiInitializer } from "discourse/lib/api";
import UserSignaturePoster from "../components/user-signature-poster";
import { getSignatureValue, signatureFieldKey } from "../lib/signature-field";

export default apiInitializer((api) => {
  class UserSignatureOutlet extends Component {
    static shouldRender(args) {
      if (!signatureFieldKey()) {
        return false;
      }

      return !!getSignatureValue(args.post?.user);
    }

    <template>
      <UserSignaturePoster @post={{@post}} />
    </template>
  }

  api.renderAfterWrapperOutlet("post-meta-data-poster-name", UserSignatureOutlet);
});
