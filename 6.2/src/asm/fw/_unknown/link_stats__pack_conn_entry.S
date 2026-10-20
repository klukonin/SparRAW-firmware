/* link_stats__pack_conn_entry @ 0x8cdd7c, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hw_sysapi_get_beamforming_statistics
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global link_stats__pack_conn_entry
link_stats__pack_conn_entry:
	.global L_8cdd7c
L_8cdd7c:
	ld_s r2,[r0,0x2c]
L_8cdd7e:
	stb_s r2,[r1]
L_8cdd80:
	ld_s r2,[r0,0x30]
L_8cdd82:
	stb_s r2,[r1,0x1]
L_8cdd84:
	ldb r2,[r0, 0x3a]
L_8cdd88:
	stb_s r2,[r1,0x2]
L_8cdd8a:
	ldb r2,[r0, 0x3b]
L_8cdd8e:
	stb_s r2,[r1,0x3]
L_8cdd90:
	ldb_s r2,[r0,0x9]
L_8cdd92:
	stb_s r2,[r1,0x4]
L_8cdd94:
	ldb_s r2,[r0,0x8]
L_8cdd96:
	stb_s r2,[r1,0x5]
L_8cdd98:
	ldb_s r2,[r0,0x6]
L_8cdd9a:
	stb_s r2,[r1,0x6]
L_8cdd9c:
	ld_s r2,[r0,0x10]
L_8cdd9e:
	st_s r2,[r1,0x8]
L_8cdda0:
	ldb.x r2,[r0, 0xc]
L_8cdda4:
	st_s r2,[r1,0xc]
L_8cdda6:
	ld_s r2,[r0,0x18]
L_8cdda8:
	ld_s r3,[r0,0x14]
L_8cddaa:
	st_s r2,[r1,0x14]
L_8cddac:
	st_s r3,[r1,0x10]
L_8cddae:
	ld_s r2,[r0,0x20]
L_8cddb0:
	ld_s r3,[r0,0x1c]
L_8cddb2:
	st_s r2,[r1,0x1c]
L_8cddb4:
	st_s r3,[r1,0x18]
L_8cddb6:
	ld_s r2,[r0,0x24]
L_8cddb8:
	st_s r2,[r1,0x20]
L_8cddba:
	ld_s r2,[r0,0x28]
L_8cddbc:
	stw_s r2,[r1,0x24]
L_8cddbe:
	ldb_s r2,[r0,0x5]
L_8cddc0:
	stw_s r2,[r1,0x26]
L_8cddc2:
	ld_s r0,[r0,0x40]
L_8cddc4:
	j_s.d [blink]
L_8cddc6:
	st_s r0,[r1,0x28]
