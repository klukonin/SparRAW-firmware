/* mac__program_886c00_entry @ 0x8ea360, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mlme_sm__disconnect_ev_handle
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac__program_886c00_entry
mac__program_886c00_entry:
	.global L_8ea360
L_8ea360:
	push_s blink
L_8ea362:
	mov_s r3,0x886c00
L_8ea368:
	st_s r0,[r3]
L_8ea36a:
	st_s r1,[r3,0x4]
L_8ea36c:
	st_s r2,[r3,0x8]
L_8ea36e:
	mov_s r0,0x886b80
L_8ea374:
	st 0x80000000,[r0, 0x7c]
L_8ea37c:
	st 0x40000000,[r0, 0x78]
L_8ea384:
	sync
	.global L_8ea388
L_8ea388:
	mov_s r0,0x886b80
L_8ea38e:
	ld_s r0,[r0,0x78]
L_8ea390:
	bbit1 r0,0x1d,L_8ea388
L_8ea394:
	pop_s blink
L_8ea396:
	j_s [blink]
