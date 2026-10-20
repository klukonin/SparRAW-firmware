/* mtp_queue__byte_by_index @ 0x92ff68, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mtp_queue__release_mgmt, mtp_service__dispatch, rx__program_mac_and_wait, rx_flow__run
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mtp_queue__byte_by_index
mtp_queue__byte_by_index:
	.global L_92ff68
L_92ff68:
	mov_s r1,0x80268c
L_92ff6e:
	mul64 r0,0x2c
L_92ff72:
	j_s.d [blink]
L_92ff74:
	ldb r0,[r1,mlo]
