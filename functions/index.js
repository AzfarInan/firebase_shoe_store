const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();
const db = admin.firestore();

// Firebase Function
exports.calculateAverageProductRatings = functions.https.onCall(async (data, context) => {
  const productId = data.productId; // Get the productId from the function's data

  if (!productId) {
    throw new functions.https.HttpsError('invalid-argument', 'The function must be called with one argument "productId" containing the ID of the product to update.');
  }

  const productDoc = await db.collection("products").doc(productId).get();

  if (!productDoc.exists) {
    throw new functions.https.HttpsError('not-found', `Product with ID ${productId} not found.`);
  }

  const productData = productDoc.data();
  const reviews = productData.reviews || [];

  if (reviews.length > 0) {
    const totalRating = reviews.reduce((total, review) => total + (review.rating || 0), 0);
    const averageRating = totalRating / reviews.length;

    // Update the product document with the calculated average rating under the 'ratings' param
    await productDoc.ref.update({ "ratings": averageRating });

    return { message: 'Average rating for product ${productId} calculated and updated successfully.' };
  } else {
    return { message: 'Product ${productId} has no reviews to calculate average rating.' };
  }
});
