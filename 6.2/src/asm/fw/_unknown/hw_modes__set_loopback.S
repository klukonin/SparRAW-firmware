/* hw_modes__set_loopback @ 0x8d76ec, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwf_calib__release_hw
 * Зовёт сам: __ld_r13_to_r13_ret, hwd_abif__caf_lpbk_mode, hwd_abif__lpbk_mode_switches_config, hwd_mac__sxd_mode_neutral, hwd_mac__trigger_sxd_tx_mode
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hw_modes__set_loopback
hw_modes__set_loopback:
	.global L_8d76ec
L_8d76ec:
	push_s blink
L_8d76ee:
	push_s r13
L_8d76f0:
	mov_s r13,r1
L_8d76f2:
	breq_s r0,0,L_8d770c
L_8d76f4:
	bl.d L_8ce5e8
L_8d76f8:
	mov_s r0,0x0
L_8d76fa:
	mov_s r0,0x3
L_8d76fc:
	mov_s r1,0x2
L_8d76fe:
	bl.d L_8ceb2c
L_8d7702:
	mov_s r2,0x0
L_8d7704:
	bl.d L_8d1008
L_8d7708:
	mov_s r0,r13
L_8d770a:
	b_s L_8d7710
	.global L_8d770c
L_8d770c:
	bl L_8d0fe0
	.global L_8d7710
L_8d7710:
	b L_8c025c
