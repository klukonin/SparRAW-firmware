/* calib_req__fill @ 0x8c182c, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_silent_rssi_sparrow__correction_alg, hwf_calib_all, wmi_ut_handler
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global calib_req__fill
calib_req__fill:
	.global L_8c182c
L_8c182c:
	st_s r2,[r0]
L_8c182e:
	stb_s r3,[r0,0x4]
L_8c1830:
	j_s.d [blink]
L_8c1832:
	st r4,[r0, 0x8]
L_8c1836:
	nop_s
	.global L_8c1838
L_8c1838:
	mov_s r1,0x0
L_8c183a:
	st_s r1,[r0]
L_8c183c:
	stb_s r1,[r0,0x4]
L_8c183e:
	mov r1,-0x1
L_8c1842:
	j_s.d [blink]
L_8c1844:
	st_s r1,[r0,0x8]
L_8c1846:
	nop_s
