/* mac_bringup__prog_881000 @ 0x8f3e5c, 124 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__mac_bringup
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac_bringup__prog_881000
mac_bringup__prog_881000:
	.global L_8f3e5c
L_8f3e5c:
	push_s blink
L_8f3e5e:
	mov_s r1,0x3
L_8f3e60:
	mov_s r0,0x881000
L_8f3e66:
	st_s r1,[r0,0x2c]
L_8f3e68:
	sync
L_8f3e6c:
	mov_s r1,0x1
L_8f3e6e:
	mov_s r0,0x881100
L_8f3e74:
	st_s r1,[r0,0x44]
L_8f3e76:
	sync
L_8f3e7a:
	mov_s r1,0x1
L_8f3e7c:
	mov_s r0,0x881100
L_8f3e82:
	st_s r1,[r0,0x54]
L_8f3e84:
	sync
L_8f3e88:
	mov_s r1,0x1
L_8f3e8a:
	mov_s r0,0x881100
L_8f3e90:
	st_s r1,[r0,0x4c]
L_8f3e92:
	sync
L_8f3e96:
	mov_s r1,0x1
L_8f3e98:
	mov_s r0,0x881100
L_8f3e9e:
	st_s r1,[r0,0x60]
L_8f3ea0:
	sync
L_8f3ea4:
	mov_s r1,0x1
L_8f3ea6:
	mov_s r0,0x881100
L_8f3eac:
	st_s r1,[r0,0x70]
L_8f3eae:
	sync
L_8f3eb2:
	mov_s r1,0x1
L_8f3eb4:
	mov_s r0,0x881100
L_8f3eba:
	st_s r1,[r0,0x68]
L_8f3ebc:
	sync
L_8f3ec0:
	mov_s r1,0x5
L_8f3ec2:
	mov_s r0,0x881280
L_8f3ec8:
	st_s r1,[r0,0xc]
L_8f3eca:
	st_s r1,[r0,0x14]
L_8f3ecc:
	st_s r1,[r0,0x1c]
L_8f3ece:
	st_s r1,[r0,0x28]
L_8f3ed0:
	st_s r1,[r0,0x30]
L_8f3ed2:
	st_s r1,[r0,0x38]
L_8f3ed4:
	pop_s blink
L_8f3ed6:
	j_s [blink]
