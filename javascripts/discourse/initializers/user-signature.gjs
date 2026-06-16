import Component from "@glimmer/component";
import { apiInitializer } from "discourse/lib/api";
import UserSignaturePoster from "../components/user-signature-poster";
import { getSignatureValue, signatureFieldKey } from "../lib/signature-field";

export default apiInitializer((api) => {
  class UserSignatureOutlet extends Component {
    static shouldRender(args, _context, owner) {
      if (!signatureFieldKey()) {
        return false;
      }

      if (getSignatureValue(args.post?.user)) {
        return true;
      }

      const currentUser = owner.lookup("service:current-user");
      return currentUser?.id === args.post?.user_id;
    }

    <template>
      <UserSignaturePoster @post={{@post}} />
    </template>
  }

  api.renderAfterWrapperOutlet("post-meta-data-poster-name", UserSignatureOutlet);
});
