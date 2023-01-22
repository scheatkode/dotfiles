/*
 * usbreset -- send a USB port reset signal to a USB device.
 */

#include <fcntl.h> /* open, O_WRONLY */
#include <stdio.h>
#include <unistd.h> /* close */

#include <sys/ioctl.h> /* ioctl */

#include <linux/usbdevice_fs.h> /* USBDEVFS_RESET */

// TODO: BSD compat
// #include <sys/usb/usb_ioctl.h>
// - USB_FS_START
// - USB_FS_STOP
// - USB_FS_COMPLETE
// - USB_FS_INIT
// - USB_FS_UNINIT
// - USB_FS_OPEN
// - USB_FS_CLOSE

int main(int argc, char **argv)
{
	if (argc != 2) {
		fprintf(stderr, "Usage: usbreset device-filename\n");
		return 1;
	}

	int fd = open(argv[1], O_WRONLY);
	if (fd < 0) {
		perror("Error opening device");
		return 1;
	}

	int rc = ioctl(fd, USBDEVFS_RESET, 0);
	if (rc < 0) {
		perror("Ioctl error");
		close(fd);
		return 1;
	}

	close(fd);
	return 0;
}
