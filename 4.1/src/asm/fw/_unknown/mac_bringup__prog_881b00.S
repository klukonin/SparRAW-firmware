/* mac_bringup__prog_881b00 @ 0x8ee8a8, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__mac_bringup
 */
	.section .text.mac_bringup__prog_881b00,"ax",@progbits
	.global mac_bringup__prog_881b00
mac_bringup__prog_881b00:
	.global L_8ee8a8
L_8ee8a8:
	mov_s r0,0x8
L_8ee8aa:
	mov_s r1,0x881b00
L_8ee8b0:
	st_s r0,[r1,0x20]
L_8ee8b2:
	st 0x3aaaa,[r1, 0x18]
L_8ee8ba:
	mov_s r0,0x0
L_8ee8bc:
	st_s r0,[r1,0x1c]
L_8ee8be:
	ld_s r0,[r1,0x24]
L_8ee8c0:
	mov_s r2,0x881b80
L_8ee8c6:
	bclr_s r0,r0,0x0
L_8ee8c8:
	st_s r0,[r1,0x24]
L_8ee8ca:
	ld_s r0,[r2,0x8]
L_8ee8cc:
	bclr_s r0,r0,0x7
L_8ee8ce:
	st_s r0,[r2,0x8]
L_8ee8d0:
	ld_s r0,[r1,0x34]
L_8ee8d2:
	and r0,r0,0xffff0000
L_8ee8da:
	bset_s r0,r0,0x3
L_8ee8dc:
	st_s r0,[r1,0x34]
L_8ee8de:
	ld_s r0,[r1,0x34]
L_8ee8e0:
	extw_s r0,r0
L_8ee8e2:
	or r0,r0,0xdd860000
L_8ee8ea:
	st_s r0,[r1,0x34]
L_8ee8ec:
	ld_s r0,[r2,0x14]
L_8ee8ee:
	bset_s r0,r0,0x1
L_8ee8f0:
	st_s r0,[r2,0x14]
L_8ee8f2:
	ld_s r0,[r2,0x14]
L_8ee8f4:
	bset_s r0,r0,0xb
L_8ee8f6:
	st_s r0,[r2,0x14]
L_8ee8f8:
	ld_s r0,[r2,0x14]
L_8ee8fa:
	bset_s r0,r0,0xa
L_8ee8fc:
	st_s r0,[r2,0x14]
L_8ee8fe:
	ld_s r0,[r2,0x14]
L_8ee900:
	bclr_s r0,r0,0x6
L_8ee902:
	st_s r0,[r2,0x14]
L_8ee904:
	ld_s r0,[r2,0x14]
L_8ee906:
	bclr_s r0,r0,0x7
L_8ee908:
	st_s r0,[r2,0x14]
L_8ee90a:
	j_s [blink]
