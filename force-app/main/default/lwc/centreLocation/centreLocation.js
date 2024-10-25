import { LightningElement, wire } from 'lwc';
import getAllCentres from '@salesforce/apex/CentreController.getAllCentres';

export default class CentreLocation extends LightningElement {
  mapFocus = { location: { Latitude: 52.22264, Longitude: 21.03124 } };
  centres = [];
  mapMarkers = [];

  @wire(getAllCentres)
  loadCentres({ error, data }) {
    if (data) {
      this.mapMarkers = data.map(centre => {
        const Latitude = centre.Location__Latitude__s;
        const Longitude = centre.Location__Longitude__s;
        return {
          location: { Latitude, Longitude },
          title: centre.Name,
          description: `Coords: ${Latitude}, ${Longitude}`
        };
      });
    } else if (error) {
      console.error('Error fetching centres:', error);
    }
  }
}