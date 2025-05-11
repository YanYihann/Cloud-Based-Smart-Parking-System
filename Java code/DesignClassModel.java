import java.util.*;

public class DesignClassModel {
    public abstract class User {
    }

    class Member extends User {
        private String username;
        private String password;
        private String email;
        private String fullName;
        private String phone;
        private String licensePlate;

        public boolean login(String username, String password) {
            return true;
        }

        public void logout() {
        }

        public Booking reserveSpot(String area, String floor, Date entryTime) {
            return null;
        }

        public List<Booking> viewBookings() {
            return new ArrayList<>();
        }

        public void modifyBooking(String bookingId, Date newEntryTime) {
        }

        public void cancelBooking(String bookingId) {
        }

        public void payParkingFee(String bookingId) {
        }
    }

    class Guest extends User {
        private String licensePlate;

        public Member register(String username, String password, String email, String fullName, String phone, String licensePlate) {
            return new Member();
        }

        public int viewAvailability(String area, String floor) {
            return 0;
        }

        public void payForParking(String licensePlate) {
        }
    }

    class Admin {
        private String username;
        private String password;

        public boolean login(String username, String password) {
            return true;
        }

        public void logout() {
        }

        public Admin register(String username, String password, String email, String fullName, String phone) {
            return new Admin();
        }

        public void manageReservations() {
        }

        public void setPrice(float newPrice) {
        }

        public void manageParkingSpots() {
        }

        public void checkOccupancySituation() {
        }

        public void manageMemberInformation() {
        }
    }

    class ParkingArea {
        private String name;

        public List<Floor> getFloors() {
            return new ArrayList<>();
        }
    }

    class Floor {
        private String name;

        public List<ParkingSpot> getSpots() {
            return new ArrayList<>();
        }

        public int getAvailableSpots() {
            return 0;
        }
    }

    class ParkingSpot {
        private String spotNumber;
        private SpotStatus status;

        public void reserve() {
        }

        public void release() {
        }

        public void updateStatus(SpotStatus status) {
            this.status = status;
        }
    }

    class IOTSensor {
        public boolean detectCar() {
            return false;
        }

        public void updateParkingSpotStatus(ParkingSpot spot) {
        }
    }

    class LicensePlateRecognitionSystem {
        public Date recognizeEntry(String licensePlate) {
            return new Date();
        }

        public Date recognizeExit(String licensePlate) {
            return new Date();
        }

        public String scanPlate() {
            return "ABC123";
        }
    }

    class BookingService {
        public Booking createBooking(Member member, String area, String floor, Date entryTime) {
            return new Booking();
        }

        public List<Booking> getBookingsByMember(Member member) {
            return new ArrayList<>();
        }

        public void modifyBooking(String bookingId, Date newEntryTime) {
        }

        public void cancelBooking(String bookingId) {
        }

        public List<Booking> getAllBookings() {
            return new ArrayList<>();
        }
    }

    class PaymentService {
        public Payment payDeposit(Booking booking) {
            return new Payment();
        }

        public Payment payParkingFee(Booking booking) {
            return new Payment();
        }

        public Payment payForGuest(String licensePlate, int duration) {
            return new Payment();
        }

        public QRCode generateQRCode(float amount) {
            return new QRCode();
        }

        public List<Payment> getAllPayments() {
            return new ArrayList<>();
        }

        public void setParkingFee(float price) {
        }
    }

    class SensorSimulator {
        public int simulateDuration() {
            return 0;
        }
    }

    class Booking {
        private String bookingId;
        private Member member;
        private ParkingSpot parkingSpot;
        private Date entryTime;
        private BookingStatus status;
        private boolean depositPaid;
    }

    class Payment {
        private String paymentId;
        private float amount;
        private Date time;
        private int duration;
        private Date entryTime;
        private Date exitTime;
        private String status;

        public float calculateFee(Date entryTime, Date exitTime) {
            return 0.0f;
        }
    }

    class QRCode {
        private String content;

        public void display() {
        }
    }

    class PlaceHolder {
        private boolean status;

        public void raise(String spotNumber) {
        }

        public void fall(String spotNumber) {
        }
    }

    enum SpotStatus {
        AVAILABLE, BOOKED, PARKED
    }

    enum BookingStatus {
        CONFIRMED, CANCELLED, EXITED
    }
}
