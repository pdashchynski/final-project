import { LightningElement } from "lwc";
import MyModal from "c/carDescriptionModalPage";

export default class CarDescTest extends LightningElement {
  result;
  async handleOpenClick() {
    this.result = await MyModal.open({
      // maps to developer-created `@api options`
      options: [
        { id: 1, label: "Option 1" },
        { id: 2, label: "Option 2" },
      ],
    });
    console.log(this.result);
  }
}