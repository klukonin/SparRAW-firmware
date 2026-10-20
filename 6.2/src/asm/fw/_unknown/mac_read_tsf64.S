/* mac_read_tsf64 @ 0x8e9900, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ba_setup_sm__addba_req_sent, bad_beacons__on_bi_evt, deep_sleep_enter, deep_sleep_exit, fw_log__emit1_tsf, fw_log__emit2_tsf, fw_log_emit0, fw_log_emit1, fw_log_emit2, fw_log_emit3
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac_read_tsf64
mac_read_tsf64:
	.global L_8e9900
L_8e9900:
	breq_s r2,0,L_8e990e
	.global L_8e9902
L_8e9902:
	mov_s r0,0x886e80
L_8e9908:
	ld_s r0,[r0,0x34]
L_8e990a:
	bbit0 r0,0x1f,L_8e9902
	.global L_8e990e
L_8e990e:
	mov_s r2,0x886e80
L_8e9914:
	ld_s r3,[r2,0x3c]
L_8e9916:
	st_s r3,[r1,0x4]
L_8e9918:
	ld_s r0,[r2,0x38]
L_8e991a:
	st_s r0,[r1]
L_8e991c:
	ld_s r0,[r2,0x3c]
L_8e991e:
	brne r3,r0,L_8e990e
L_8e9922:
	j_s [blink]
